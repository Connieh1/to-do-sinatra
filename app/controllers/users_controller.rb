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
      @user.save
      session[:user_id] = @user.id
      flash[:message] = "You have successfully logged in."
      redirect  "/users/#{@user.id}"
    else
      flash[:message] = "Please enter a valid username, email and password."
      redirect '/signup'
    end
  end

  get '/login' do
    if !logged_in?
      erb :'/users/login'
    else
      flash[:message] = "You must login with a valid username and password!"
      redirect '/login'
    end
  end

  post  '/login' do
    @user = User.find_by(username: params[:user][:username])
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      flash[:message] = "Successfully logged in."
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
