class AddVerifiedToUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :is_confirmed
    add_column :users, :verified, :boolean
  end
end
