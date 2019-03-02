class UsersController < ApplicationController

  get '/users/new' do
    if !logged_in?
    erb :'users/new'
    else
      redirect 'user/show'
    end
  end

  post '/users' do
    if params[:name] == "" || params[:email] == "" || params[:password] == ""
      redirect to '/users/new'
    else
      @user = User.new(:name => params[:name], :email => params[:email], :password => params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect to '/users/show'
    end
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
