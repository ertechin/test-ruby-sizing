class CreateDonations < ActiveRecord::Migration[7.0]
  def change
    create_table :donations do |t|
      t.integer :gyear
      t.integer :class_count, default: 0
      t.integer :donate_count, default: 0
      
      t.timestamps
    end
  end
end
