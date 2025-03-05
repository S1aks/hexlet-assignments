class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end
  
  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_param)
    if @task.save
      flash[:notice] = 'Task saved.'
      redirect_to @task
    else
      flash[:error] = 'Errors in form.'
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_param)
      flash[:notice] = 'Task updated.'
      redirect_to @task
    else
      flash[:error] = 'Errors in form.'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task = Task.find(params[:id])
    if @task.destroy
      flash[:notice] = 'Task destroyed.'
      redirect_to tasks_path
    else
      flash[:error] = 'Error delete task.'
      redirect_back fallback_location: :tasks_path
    end
  end

  private

  def task_param
    params.require(:task).permit(:name, :description, :status, :creator, :performer, :completed)
  end
end
