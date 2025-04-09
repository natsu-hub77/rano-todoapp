class CommentsController < ApplicationController
  before_action :set_board, only: [:new, :create]

  def new
    task = @board.tasks.find(params[:task_id])
    @comment = task.comments.build(user: current_user)
  end

  def create
    task = @board.tasks.find(params[:task_id])
    @comment = task.comments.build(comment_params.merge(user: current_user))
    if @comment.save
      redirect_to board_task_path(@board, task), notice: 'コメントを追加'
    else
      flash.now[:error] = '更新できませんでした'
      render :new
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_board
    @board = Board.find(params[:board_id])
  end
end
