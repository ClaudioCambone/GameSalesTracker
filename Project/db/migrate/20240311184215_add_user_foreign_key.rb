class AddUserForeignKey < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :collections, :users
  end
end
