class CommentsController < ApplicationController
    def create
      @comment = current_user.comments.new(comment_params)
  
      if @comment.save
        redirect_to details_game_path(id: @comment.gameplain), notice: 'Comment was successfully created.'
      else
        render 'games/details', plain: comment_params[:gameplain], alert: 'Error creating comment.'
      end
    end

    def edit
        @comment = current_user.comments.find(params[:id])
    end

    def update
        @comment = Comment.find(params[:id])
        if @comment.update(comment_params)
          # Handle successful update
          redirect_to details_game_path(@comment.gameplain), notice: 'Comment was successfully updated.'
        else
          # Handle failed update
          render 'games/details', plain: comment_params[:gameplain], alert: 'Error creating comment.'
        end
    end
  
    private
  
    def comment_params
      params.require(:comment).permit(:body, :like, :gameplain)
    end
  end
  