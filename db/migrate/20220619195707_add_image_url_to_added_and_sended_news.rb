class AddImageUrlToAddedAndSendedNews < ActiveRecord::Migration[7.0]
  def change
    add_column :added_news, :image_urls, :text, array: true, default: []
    add_column :sended_news, :image_urls, :text, array: true, default: []
  end
end
