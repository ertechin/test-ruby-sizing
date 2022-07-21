class ChangeIsDeletedFieldDefaultValueOnUsers < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :is_deleted, :boolean, default: false
  end
end
