class User < ApplicationRecord
  before_create :add_jti
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image

  validate :acceptable_image

  def add_jti
    self.jti ||= SecureRandom.uuid
  end

  def send_confirmed_email
    UserMailer.with(user: self).send("confirm_email").deliver_now
  end

  def self.update_profile_image(params)
    user = User.find(params[:user_id])
    user.profile_image.attach(params[:image])
  end

  def acceptable_image
    return unless profile_image.attached?

    unless profile_image.byte_size <= 1.megabyte
      errors.add(:profile_image, "is too big")
    end

    acceptable_types = ["image/jpeg", "image/png"]

    unless acceptable_types.include?(profile_image.content_type)
      errors.add(:profile_image, "must be a JPEG or PNG")
    end
  end

  def self.send_welcome_mail(params)
    UserMailer.with(params).send("welcome_email").deliver_now
  end

end
