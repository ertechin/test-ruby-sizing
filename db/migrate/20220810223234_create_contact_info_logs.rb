class CreateContactInfoLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :contact_info_logs do |t|
      t.boolean :contact_info
      t.belongs_to :user, index: true
      t.timestamps
    end
  end
end
