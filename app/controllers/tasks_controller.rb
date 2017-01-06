class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.where(user_id: params[:user_id]).where.not(done: true, status: 1).order(updated_at: :desc)
    @user = User.find(params[:user_id])
  end

  def show
     @user = User.find(params[:user_id])
     @charger = User.find(@task.charge_id)
     redirect_to(user_tasks_path(current_user)) unless current_user == @charger || current_user == @user
  end

  def new
     @task = Task.new(user_id: params[:user_id], charge_id: params[:user_id])
  end


  def edit
  end

  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to user_tasks_url, notice: 'タスクを登録しました。' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to user_tasks_url, notice: 'タスクを編集しました。' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to user_tasks_url, notice: 'タスクを削除しました。' }
      format.json { head :no_content }
    end
  end

  private
  def set_task
      @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:user_id, :title, :content, :deadline, :charge_id, :done, :status)
  end

  def correct_user
    @user = User.find(params[:user_id])
    redirect_to(user_tasks_path(current_user)) unless current_user == @user
  end
end
