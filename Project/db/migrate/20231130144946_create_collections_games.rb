class CreateCollectionsGames < ActiveRecord::Migration[6.0]
  def change
    create_table :collections_games, id: false do |t|
      t.belongs_to :collection
      t.belongs_to :game
    end
  end
end
