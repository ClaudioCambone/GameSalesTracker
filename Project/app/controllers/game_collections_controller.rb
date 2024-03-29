class GameCollectionsController < ApplicationController
  before_action :authenticate_user!

  def new
    @game_id = params[:game_id]
    @collection = current_user.collections.find(params[:collection_id])
    @available_collections = current_user.collections.where.not(id: @collection.id)
  end

  def create
    @game_id = params[:game_id]
    @collection = current_user.collections.find(params[:collection_id])
  
    begin
      GameCollection.transaction do
        # Find the corresponding game using the plain attribute
        game = GameCollection.find_by(game_id: @game_id, collection_id: @collection)
  
        if game.present? && @collection.game_collections.include?(game)
          flash[:alert] = "Game is already in the collection."
        else
          # If the game doesn't exist, initialize a new instance
          game ||= GameCollection.new(game_id: @game_id, collection_id: @collection)
  
          # Create a new entry in the GameCollection join table
          @collection.game_collections << game
  
          flash[:notice] = "Game was successfully added to the collection."
        end
      end
    rescue ActiveRecord::RecordInvalid => e
      # Handle validation errors
      flash[:alert] = "Error adding game to collection: #{e.message}"
    end
    redirect_to details_game_path(@game_id)
  end
  
  def destroy
    @game_id = params[:game_id]
    @collection_id = params[:id]
  
    begin
      GameCollection.transaction do
        # Find the game based on the game_plain
        game = GameCollection.find_by(game_id: @game_id)
  
        if game.present?
          # Find the collection based on the collection_id
          collection = current_user.collections.find_by(id: @collection_id)

          if collection.present? && collection.game_collections.include?(game)
            # Remove the game from the collection
            collection.game_collections.find_by(game_id: @game_id).destroy
            redirect_to user_path, notice: 'Game was successfully removed from the collection.'
          else
            redirect_to user_path, notice: 'Collection not found or game not in the collection.'
          end
        else
          redirect_to user_path, notice: 'Game not found.'
        end
      end
    rescue ActiveRecord::RecordInvalid => e
      # Handle validation errors
      redirect_to user_path, notice: "Error removing game from collection: #{e.message}"
    end
  end
end