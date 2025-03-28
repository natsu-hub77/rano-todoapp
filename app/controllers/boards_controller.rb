class BoardsController < ApplicationController
    def index
        @boards = Board.all
    end


    def show
        @board = Board.find(params[:id])
    end

    def new
        @board = current_user.boards.build
    end

    def create 
        @board = current_user.boards.build(board_params)
        if @board.save
            redirect_to board_path(@board), notice: '保存できました'
        else
            render :new, notice: '保存できませんでした'
        end
    end

    def edit
        @board = current_user.boards.find(params[:id])
    end

    def update
        @board = current_user.boards.find(params[:id])
        if @board.update(board_params)
            redirect_to board_path(@board), notice: '更新できました'
        else
            flash.now[:error] = '更新できませんでした'
            render :edit
        end
    end

    private
    def board_params
        params.require(:board).permit(:title, :content)
    end
end