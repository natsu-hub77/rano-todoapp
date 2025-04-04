class TasksController < ApplicationController
  before_action :correct_user, only: [:edit, :update]

  def index
    @tasks = Tasks.all
  end

  def show
    @board = Board.find(params[:board_id])
    @tasks = @board.tasks.find(params[:id])
  end

  def new
    @board = Board.find(params[:board_id])
    @task = @board.tasks.build(user: current_user)
  end

  def create
    @board = Board.find(params[:board_id])
    @task = @board.tasks.build(task_params.merge(user: current_user))
    if @task.save
      redirect_to board_path(@board), notice: '保存できました'
    else
      render :new, notice: '保存できませんでした'
    end
  end

  def edit
    @board = Board.find(params[:board_id])
    @task = @board.tasks.find(params[:id])
  end

  def update
    @board = Board.find(params[:board_id])
    @task = @board.tasks.find(params[gb :id])
    if @task.update(task_params)
      redirect_to board_task_path(@board, @task), notice: '更新できました'
    else
      flash.now[:error] = '更新できませんでした'
      render :edit
    end
  end

  private
  def task_params
    params.require(:task).permit(:title, :content, :deadline, :eyecatch)
  end

  def correct_user
    @board = Board.find(params[:board_id])
    @task = @board.tasks.find(params[:id])

    unless @task.user == current_user
      redirect_to board_path(@board), alert: 'このタスクを編集する権限がありません'
    end
  end
end