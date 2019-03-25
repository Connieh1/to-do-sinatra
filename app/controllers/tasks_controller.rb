class TasksController < ApplicationController

  get '/tasks' do
    redirect_if_not_logged_in
      @tasks = current_user.tasks
        erb :'/tasks/index'
  end

  get '/tasks/new' do
    if logged_in?
      erb :'/tasks/new'
    else
      redirect '/login'
    end
  end

  post '/tasks' do
    if logged_in?
      if params[:task][:name] != ""
        # @task = current_user.tasks.build(name: params[:task][:name], description: params[:task][:description], deadline: params[:task][:deadline])
        @task = current_user.tasks.build(params[:task])
        @task.save
        redirect "/tasks/#{@task.id}"
      else
        redirect '/tasks/new'
      end
    else
      redirect '/login'
    end
  end

  get '/tasks/:id' do
    if logged_in?
      @task = Task.find_by(id: params[:id])
      erb :'/tasks/show'
    else
      redirect '/login'
    end
  end

  get '/tasks/:id/edit' do
    if logged_in?
      @task = Task.find_by_id(params[:id])
      if @task && @task.user == current_user
        erb :'tasks/edit'
      else
        redirect to '/tasks'
      end
    else
      redirect to '/login'
    end
  end

  patch '/tasks/:id' do
    @task = Task.find_by_id(params[:id])
    redirect_if_not_authorized(@task)
      if params[:content] != ""
          @task.update(params[:task])
            redirect to "/tasks/#{@task.id}"
        else
          redirect to "/tasks/#{@task.id}/edit"
        end
  end


  delete "/tasks/:id" do
    if logged_in?
      @task = Task.find_by_id(params[:id])
      if @task && @task.user == current_user
        @task.delete
      end
      redirect to "/users/#{current_user.id}"
    else
      redirect to '/'
    end
  end


end
