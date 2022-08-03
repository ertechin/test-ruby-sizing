class ChangeContactInfoDefaultValue < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :contact_info, :boolean, default: false
  end
end
