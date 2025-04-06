class TasksController < ApplicationController
  def index
    @tasks = Tasks.all
  end

  def show
    @board = Board.find(params[:board_id])
    @tasks = @board.tasks.find(params[:id])
    @comments = @tasks.comments
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
    @task = @board.tasks.find(params[:id])
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
end