class UsersController < ApplicationController

  get '/signup' do
    if !logged_in?
      erb :'users/signup'
    else
      redirect 'users/show'
    end
  end

  post '/signup' do
    if params[:user][:name] !="" || params[:user][:email] != "" || params[:user][:password] != ""
      @user = User.new(params[:user])
      if @user.save
        session[:user_id] = @user.id
        redirect  "/users/#{@user.id}"
      else
        redirect '/signup'
      end
    else
      # flash[:message] = "Please enter a valid username, email and password."
      redirect '/signup'
    end
  end

  get '/login' do
    if !logged_in?
      erb :'/users/login'
    else
      redirect '/login'
    end
  end

  post  '/login' do
    @user = User.find_by(username: params[:user][:username])
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect "/users/#{@user.id}"
    else
      redirect '/login'
    end
  end

  get '/users/:id' do
    if logged_in?
    @user = User.find_by(id: params[:id])
    erb :"/users/show"
    end
  end

  get '/logout' do
    if logged_in?
      session.destroy
      redirect '/login'
    else
      redirect '/'
    end
  end

end
