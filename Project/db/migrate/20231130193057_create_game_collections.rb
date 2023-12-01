class CreateGameCollections < ActiveRecord::Migration[7.0]
  def change
    create_table :game_collections do |t|
      t.string :plain
      t.references :collection, null: false, foreign_key: true

      t.timestamps
    end
  end
end
