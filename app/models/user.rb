class User < ApplicationRecord
  before_create :add_jti
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def add_jti
    self.jti ||= SecureRandom.uuid
  end

  def send_confirmed_email
    UserMailer.with(user: self).send("confirm_email").deliver_now
  end

end
