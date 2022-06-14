class AddRequiredColumnsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :token, :string
    add_column :users, :phone, :string
    add_column :users, :profile_image, :string
    add_column :users, :full_name, :string
    add_column :users, :job, :string
    add_column :users, :city, :string
    add_column :users, :country, :string
    add_column :users, :about, :string
    add_column :users, :g_year, :integer
    add_column :users, :contact_info, :boolean, default: true
    add_column :users, :is_confirmed, :boolean
    add_column :users, :mail_activeted, :boolean
    add_column :users, :is_admin, :boolean
    add_column :users, :is_deleted, :boolean
    add_column :users, :kvkk_confirmed_date, :string
  end
end
