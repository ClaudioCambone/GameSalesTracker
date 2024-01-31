class AddUniqueIndexToGameCollections < ActiveRecord::Migration[6.0]
  def change
    add_index :game_collections, [:plain, :collection_id], unique: true
  end
end
