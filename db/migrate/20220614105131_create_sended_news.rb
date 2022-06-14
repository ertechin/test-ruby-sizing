class CreateSendedNews < ActiveRecord::Migration[7.0]
  def change
    create_table :sended_news do |t|
      t.string :context
      t.string :description
      t.string :title
      t.string :tag
      t.string :images
    end
  end
end
