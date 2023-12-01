class CollectionsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  
  def show
    @collection = Collection.find(params[:id])
    @games = @collection.games
  end

  def index
    @collections = current_user.collections
  end

  def create
    @collection = current_user.collections.build(collection_params)

    if @collection.save
      redirect_to root_path, notice: 'Collection was successfully created.'
    else
      redirect_to root_path, notice: 'There was an error in creating your collection.'
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
