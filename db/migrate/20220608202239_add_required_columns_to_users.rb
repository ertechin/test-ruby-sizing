class AddRequiredColumnsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :token, :string
    add_column :users, :phone, :string
    add_column :users, :profile_image, :string
    add_column :users, :fullname, :string
    add_column :users, :job, :string
    add_column :users, :city, :string
    add_column :users, :country, :string
    add_column :users, :about, :string
    add_column :users, :gyear, :integer
    add_column :users, :contactinfo, :boolean, default: true
    add_column :users, :confirmed, :boolean
    add_column :users, :mail_activeted, :boolean
    add_column :users, :is_admin, :boolean
    add_column :users, :is_deleted, :boolean
  end
end
