class UsersController < ApplicationController

  get '/signup' do
    if !logged_in?
    erb :'users/signup'
    else
      redirect 'users/show'
    end
  end

  post '/signup' do
    if params[:user][:username] == "" || params[:user][:email] == "" || params[:user][:password] == ""
      redirect to '/signup'
    else
      @user = User.new(params[:user])
      if @user.save
        session[:user_id] = @user.id
        redirect "/users/#{@user.id}"
      else
        redirect  '/signup'
      end
    end
    redirect '/signup'
  end

  get '/login' do
    if !logged_in?
      erb :'/users/login'
    else
      current_user
      redirect "/users/show"
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

  # get '/users' do
  #   @users = Users.all
  # end


  get '/users/:id' do
    @user = User.find_by(id: params[:id])
    erb :"/users/show"
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end



end
