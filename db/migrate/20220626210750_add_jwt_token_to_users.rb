class AddJwtTokenToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :jwt_token, :string
  end
end
