class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.references :user, null: false, foreign_key: true
      t.text :body
      t.string :gameplain
      t.boolean :like

      t.timestamps
    end
  end
end
