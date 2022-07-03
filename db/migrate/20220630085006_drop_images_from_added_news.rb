class DropImagesFromAddedNews < ActiveRecord::Migration[7.0]
  def change
    remove_column :added_news, :images
  end
end
