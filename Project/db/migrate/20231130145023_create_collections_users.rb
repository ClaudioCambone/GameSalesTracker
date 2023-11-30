class CreateCollectionsUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :collections_users, id: false do |t|
      t.belongs_to :collection
      t.belongs_to :user
    end
  end
end
