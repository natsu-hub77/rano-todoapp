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

    def edit
        @board = Board.find(params[:id])
    end

    def update 
    end
end

    private
    def board_params
        params.require(:board).permit(:title, :content)
    end
end