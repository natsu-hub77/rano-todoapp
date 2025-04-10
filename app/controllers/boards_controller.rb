class BoardsController < ApplicationController
    before_action :set_board, only: [:edit, :update]

    def index
        @boards = Board.all
    end

    def show
        @board = Board.find(params[:id])
        @tasks = Task.where(board_id: @board.id)
    end

    def new
        @board = current_user.boards.build
    end

    def create
        @board = current_user.boards.build(board_params)
        if @board.save
            redirect_to board_path(@board), notice: '保存できました'
        else
            flash.now[:error] = '保存できませんでした'
            render :new
        end
    end

    def edit
    end

    def update
        if @board.update(board_params)
            redirect_to board_path(@board), notice: '更新できました'
        else
            flash.now[:error] = '更新できませんでした'
            render :edit
        end
    end

    def destroy
        board = current_user.boards.find(params[:id])
        board.destroy!
        redirect_to root_path, notice: '削除しました'
    end

    private
    def board_params
        params.require(:board).permit(:title, :content)
    end

    def set_board
        @board = current_user.boards.find(params[:id])
    end

end
