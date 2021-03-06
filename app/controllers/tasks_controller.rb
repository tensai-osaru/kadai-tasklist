class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :require_user_logged_in

  def index
    @tasks = current_user.tasks.order(created_at: :desc).page(params[:page]).per(3)
  end

  
  def show
    set_task
  end

  def new
    @task = current_user.tasks.build
  end
  
  def create
    @task = Task.new(task_params)
    
    if @task.save
      flash[:success] = "Task が正常に投稿されました"
      redirect_to @task
    else
      flash.now[:danger] = "Task が投稿されませんでした"
      render :new
    end
  end
  
  def edit
    set_task
  end

  def update

    if @task.update(task_params)
      flash[:success] = "Task は正常に更新されました"
      redirect_to @task
    else
      flash.now[:danger] = "Task は更新されませんでした"
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    
    flash[:success] = "Task は正常に削除されました"
    redirect_to tasks_url
  end
  
  private
  
  def set_task
    @task = Task.find(params[:id])
    if (@task.user != current_user)
         redirect_to root_url
    end
  end
  
  def task_params
    params.require(:task).permit(:content, :status, :user_id)
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
end
