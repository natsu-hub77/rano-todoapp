class TasksController < ApplicationController
  def index
    @tasks = Tasks.all
  end

  def show
    @board = Board.find(params[:id])
    @tasks = @board.Task.find(params[:id])
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

  private
  def task_params
    params.require(:task).permit(:title, :content, :deadline, :eyecatch)
  end
end