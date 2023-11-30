class GameCollectionsController < ApplicationController
    before_action :authenticate_user!
  
    def new
      @game = Game.find(params[:game_id])
      @available_collections = @game.available_collections(current_user)
    end
  
    def create
      @game = Game.find(params[:game_id])
      @collection = current_user.collections.find(params[:collection_id])
      
      if @collection.games.include?(@game)
        redirect_to @game, alert: 'Game is already in the collection.'
      else
        @collection.games << @game
        redirect_to @game, notice: 'Game was successfully added to the collection.'
      end
    end
  end
  