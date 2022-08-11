class ContactInfoLog < ApplicationRecord
  belongs_to :user

  def self.create_contact_info_log(params)
    user = User.find_by(id: params[:id])
    ContactInfoLog.create(contact_info: params[:contact_info], user: user)
  end
end
