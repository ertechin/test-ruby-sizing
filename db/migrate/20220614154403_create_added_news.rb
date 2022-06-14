class CreateAddedNews < ActiveRecord::Migration[7.0]
  def change
    create_table :added_news do |t|
      t.string :date
      t.string :context
      t.string :description
      t.string :title
      t.string :tag
      t.string :images
      t.timestamps
    end
  end
end
