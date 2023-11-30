class CollectionsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]

  def index
    @collections = current_user.collections
  end

  def create
    @collection = current_user.collections.build(collection_params)

    if @collection.save
      redirect_to collections_path, notice: 'Collection was successfully created.'
    else
      render :index
    end
  end

  private

  def collection_params
    params.require(:collection).permit(:name)
  end
end
