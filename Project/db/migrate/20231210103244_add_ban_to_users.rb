class AddBanToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :banned, :boolean, default: false
    add_column :users, :ban_until, :datetime
  end
end
