class TasksController < ApplicationController
  before_action :set_board, only: [:show, :new, :create, :edit, :update]
  before_action :set_task, only: [:edit, :update]

  def index
    @tasks = Tasks.all
  end

  def show
    @tasks = @board.tasks.find(params[:id])
    @comments = @tasks.comments
  end

  def new
    @task = @board.tasks.build(user: current_user)
  end

  def create
    @task = @board.tasks.build(task_params.merge(user: current_user))
    if @task.save
      redirect_to board_path(@board), notice: '保存できました'
    else
      flash.now[:error] = '保存できませんでした'
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to board_task_path(@board, @task), notice: '更新できました'
    else
      flash.now[:error] = '更新できませんでした'
      render :edit
    end
  end

  def destroy
    board = Board.find(params[:board_id])
    task = board.tasks.find(params[:id])
    task.destroy!
    redirect_to board_path(board), notice: '削除しました'
  end

  private
  def task_params
    params.require(:task).permit(:title, :content, :deadline, :eyecatch)
  end

  def set_board
    @board = Board.find(params[:board_id])
  end

  def set_task
    @task = @board.tasks.find(params[:id])
  end
end
