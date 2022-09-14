class AddFcmRegistrationId < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :fcm_registration_id, :string
  end
end
