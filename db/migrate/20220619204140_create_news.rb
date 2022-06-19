class CreateNews < ActiveRecord::Migration[7.0]
  def change
    create_table :news do |t|
      t.string :link
      t.string :date
      t.string :title
      t.string :description
      t.string :content
      
      t.timestamps
    end
  end
end
