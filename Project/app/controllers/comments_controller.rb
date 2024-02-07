class CommentsController < ApplicationController
    def create
      @comment = current_user.comments.new(comment_params)
  
      if @comment.save
        redirect_to details_game_path(plain: @comment.gameplain), notice: 'Comment was successfully created.'
      else
        render 'games/details', plain: comment_params[:gameplain], alert: 'Error creating comment.'
      end
    end
  
    private
  
    def comment_params
      params.require(:comment).permit(:body, :like, :gameplain)
    end
  end
  