class RenamePlainColumnInGameCollections < ActiveRecord::Migration[6.0]
  def change
    rename_column :game_collections, :plain, :game_id
  end
end
