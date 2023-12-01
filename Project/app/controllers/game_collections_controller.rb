class GameCollectionsController < ApplicationController
  before_action :authenticate_user!

  def new
    @game_plain = params[:game_plain]
    @collection = current_user.collections.find(params[:collection_id])
    @available_collections = current_user.collections.where.not(id: @collection.id)
  end

  def create
    @game_plain = params[:game_plain]
    @collection = current_user.collections.find(params[:collection_id])
  
    begin
      GameCollection.transaction do
        # Find the corresponding game using the plain attribute
        game = GameCollection.find_by(plain: @game_plain)
  
        if game.present? && @collection.game_collections.include?(game)
          redirect_to root_path, alert: 'Game is already in the collection.'
        else
          # If the game doesn't exist, initialize a new instance
          game ||= GameCollection.new(plain: @game_plain)
  
          # Create a new entry in the GameCollection join table
          @collection.game_collections << game
  
          redirect_to root_path, notice: 'Game was successfully added to the collection.'
        end
      end
    rescue ActiveRecord::RecordInvalid => e
      # Handle validation errors
      redirect_to root_path, alert: "Error adding game to collection: #{e.message}"
    end
  end
  
  
  
end