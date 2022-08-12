class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :validatable

  def self.take_all_admins_email
    array = []
    result = AdminUser.select(:email).all
    result.each do |e|
      array.push e['email']
    end
    array
  end
end