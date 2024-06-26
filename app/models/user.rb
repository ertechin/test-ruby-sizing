class User < ApplicationRecord
  before_create :add_jti
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_one_attached :profile_image, dependent: :purge_later
  has_many :contact_info_logs, dependent: :destroy

  validate :acceptable_image

  def self.delete_user(params)
    user = User.find_by(id: params[:id])
    if (user.present?)
      user.destroy
      internal_api_status = 'ok'
    else
      internal_api_status = 'user_is_not_exists'
    end
  end

  def self.save_fcm_registration_id(params)
    user = User.find_by(id: params[:id])
    user.update(fcm_registration_id: params[:fcm_token])
    internal_api_status = 'ok'
  end

  def self.verified(email)
    user = User.find_by(email:)
    user.verified ? true : false
  end

  def self.save_token(email, current_token)
    user = User.find_by(email:)
    user.update(token: current_token)
  end

  def self.create_user(params)
    if !User.exists?(email: params[:email])
    user = User.new(
      password: params[:password],
      email: params[:email],
      phone: params[:phone],
      full_name: params[:full_name],
      g_year: params[:g_year],
      verified: false,
      kvkk_confirmed_date: params[:kvkk_confirmed_date]
    )
    user.save!
      @create_user_status = 'ok'
    else
      @create_user_status = 'user_is_exist'
    end
  end

  def self.forgot_password(params)
    if User.exists?(email: params[:email])
      @forgot_pw_status = true
      @new_pw = SecureRandom.hex
      user = User.find_by(email: params[:email])
      @user_name = user.full_name
      user.update(password: @new_pw)
      User.send_forgot_password_mail(params)
    else
      @forgot_pw_which_json = false
    end
  end

  def self.update_pass(params)
    user = User.find_by(id: params[:id])
    user.update(
      token: SecureRandom.hex,
      password: params[:password]
    )
  end

  def self.update_user(params)
    user = User.find_by(id: params[:id])
    user.update(
      email: params[:email],
      phone: params[:phone],
      job: params[:job],
      city: params[:city],
      country: params[:country],
      about: params[:about]
    )
  end

  def self.search(params)
    User.select(:email, :phone, :full_name, :job, :city, :country, :about, :g_year, :id)
        .where("LOWER(full_name) LIKE LOWER('%#{params[:query]}%')")
        .or(User.where('cast(g_year as text) LIKE ?', "%#{params[:query]}%"))
        .or(User.where("LOWER(city) LIKE LOWER('%#{params[:query]}%')"))
        .or(User.where("LOWER(country) LIKE LOWER('%#{params[:query]}%')"))
        .and(User.where(contact_info: true, is_deleted: false, verified: true))
  end

  def self.search_result_modifier(result)
    result.as_json.map do |res|
      image_result = ActiveStorage::Attachment.where(record_type: 'User', record_id: res['id'])
      if image_result.any?
        profile_image_url = image_result.map do |profile_image|
          profile_image.url
        end
      else
        profile_image_url=['https://gravatar.com/avatar/21db12591dfbe5681a31a09d4a6e258c?s=200&d=robohash&r=x']
      end
      res.merge!('profile_image'=>profile_image_url.first)
    end
  end

  def self.update_contact_info(params)
    user = User.find_by(id: params[:id])
    user.update(contact_info: params[:contact_info])
  end

  def add_jti
    self.jti ||= SecureRandom.uuid
  end

  def send_verified_email
    UserMailer.with(user: self).send("verified_email").deliver_now
  end

  def send_reject_email
    UserMailer.with(user: self).send("reject_email").deliver_now
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

  def self.send_forgot_password_mail(params)
    UserMailer.with(params).send("forgot_password_email").deliver_now
  end

end
