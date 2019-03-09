class TasksController < ApplicationController

  get '/tasks' do
    if logged_in?
      @tasks = Task.all
      erb :'/tasks/index'
    else
      redirect '/login'
    end
  end

  get '/tasks/new' do
    if logged_in?
      erb :'/tasks/new'
    else
      redirect '/login'
    end
  end

  get '/tasks/:id' do
    @task = Task.find_by(params[:id])
    erb :'/tasks/show'
  end

  post '/tasks' do
    if logged_in?
      if params[:task][:name] != ""
        @task = Task.create(params[:task])
        redirect "/tasks/#{@task.id}"
      else
        redirect '/tasks/new'
      end
    else
      redirect '/'
    end
  end

  get '/tasks/:id/edit' do
    @task = Task.find_by(params[:id])
    erb :'/tasks/edit'
  end

  post '/tasks/:id' do
    @task = Task.find_by(params[:id])
    @task.update(params[:task])
    redirect "/tasks/#{@task.id}"
  end

  delete '/tasks/:id' do
    @task = Task.find_by(params[:id])
    @task.destroy
  end


end
