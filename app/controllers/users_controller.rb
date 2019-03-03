class UsersController < ApplicationController

  get '/signup' do
    if !logged_in?
    erb :'users/signup'
    else
      redirect 'user/show'
    end
  end

  post '/users' do
    if params[:name] == "" || params[:email] == "" || params[:password] == ""
      redirect to '/users/signup'
    else
      @user = User.new(:name => params[:name], :email => params[:email], :password => params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect to '/users/show'
    end
  end

  get '/login' do
    if !logged_in?
    erb :'/users/login'
  end
  get '/users/:id' do
    @user = User.find_by(email: params[:email], password: params[:password])
    session[:user_id] = @user.id
    erb :"users/show"
  end

  get '/users/:id/edit' do
    @user = User.find_by(email: params[:email], password: params[:password])
    erb :'users/edit'
  end

end
