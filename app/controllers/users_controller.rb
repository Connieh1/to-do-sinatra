class UsersController < ApplicationController

  # get '/users/:slug' do
  #   @user = User.find_by_slug(params[:slug])
  #   erb :'users/show'
  # end


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
      @user.save

      session[:user_id] = @user.id
      redirect "/users/#{@user.id}"
    end
  end

  get '/login' do
    if !logged_in?
      erb :'/users/login'
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

  get '/users' do
    @users = Users.all
  end


  get '/users/:id' do
    @user = User.find_by(id: params[:id])
    erb :"/users/show"
  end

  get 'logout' do
    session.clear
    redirect '/login'
  end



end
