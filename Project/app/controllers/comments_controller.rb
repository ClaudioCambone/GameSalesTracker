class CommentsController < ApplicationController

    http_basic_authenticate_with name: "user", password: "user", only: :destroy

    def create
        @game = Game.find(params[:game_id])
        @comment = @game.comments.create(comment_params)
        redirect_to game_path(@game)
      end

      def destroy
        @game = Game.find(params[:game_id])
        @comment = @game.comments.find(params[:id])
        @comment.destroy
        redirect_to game_path(@game), status: :see_other
      end
    
      private
        def comment_params
          params.require(:comment).permit(:commenter, :body, :status)
        end
    end
