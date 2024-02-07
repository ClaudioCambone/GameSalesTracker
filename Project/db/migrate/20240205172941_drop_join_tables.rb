class DropJoinTables < ActiveRecord::Migration[7.0]
  def change
    drop_table :collections_users
    drop_table :collections_games
  end
end
