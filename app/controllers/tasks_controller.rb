class TasksController < ApplicationController

  get '/tasks' do
    @tasks = Task.all
    erb :'/tasks/index'
  end

  get '/tasks/new' do
    erb :'/tasks/new'
  end

  get '/tasks/:id' do
    @task = Task.find_by(params[:id])
    erb :'/tasks/show'
  end

  post '/tasks' do
    binding.pry
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
