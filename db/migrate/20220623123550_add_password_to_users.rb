class AddPasswordToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :password, :string, default: ""
    remove_column :sended_news, :description
  end
end
