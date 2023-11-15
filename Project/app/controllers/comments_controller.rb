class CommentsController < ApplicationController
  layout 'navbar_layout'

  before_action :authenticate_user!, except: [:index, :show]

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
