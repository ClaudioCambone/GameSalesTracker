class CollectionsController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @collection = Collection.find(params[:id])
    @games = @collection.games
  end

  def index
    @collections = current_user.collections
    
  end

  def new
    @collection = Collection.new
  end

  def create
    @collection = current_user.collections.build(collection_params)
  
    respond_to do |format|
      if @collection.save
        format.html { redirect_to user_path, notice: 'Collection was successfully created.' }
        format.js   # Render create.js.erb
      else
        format.html { redirect_to user_path, notice: 'There was an error in creating your collection.' }
        format.js   # Render create.js.erb
      end
    end
  end

  def destroy
    @collection = Collection.find(params[:id])
    @collection.destroy

    redirect_to user_path, notice: 'Collection was successfully deleted.'
  end

  private

  def collection_params
    params.require(:collection).permit(:name)
  end
end
