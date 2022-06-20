class AddUserColumnsToSendedNews < ActiveRecord::Migration[7.0]
  def change
    add_column :sended_news, :user_name, :string
    add_column :sended_news, :user_gyear, :string
    add_column :sended_news, :date, :string
  end
end
