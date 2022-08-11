class Api::V1::UsersController < ApiController
  skip_before_action :check_auth, only: %i[register forgot_password]
  respond_to :json

  def login_with_token
    @user_image_url = if current_user.profile_image.attached?
                        url_for(current_user.profile_image.variant(saver: { quality: 5 }))
                      else
                        'https://gravatar.com/avatar/21db12591dfbe5681a31a09d4a6e258c?s=200&d=robohash&r=x'
                      end
    @current_user = current_user
  end

  def register
    @create_user_status = User.create_user(register_params)
  end

  def forgot_password
    @forgot_pw_which_json = User.forgot_password(forgot_password_params)
  end

  def update_user_info
    User.update_user(update_user_info_params)
  end

  def update_password
    User.update_pass(update_password_params)
  end

  def search_user
    user = User.find_by(id: params[:api_user][:id])
    if user.contact_info
      @which_json = true
      result = User.search(search_user_params)
      @search_result = User.search_result_modifier(result)
    else
      @which_json = false
    end
  end

  def update_contact_info
    User.update_contact_info(update_contact_info_params)
    ContactInfoLog.create_contact_info_log(update_contact_info_params)
  end

  def upload_profile_image
    message = User.update_profile_image(request)
    respond_to do |format|
      format.json do
        render json: {
          status: 200,
          current_profile_image: url_for(@current_user.profile_image),
          response_message: 'Success',
          request_id: request.request_id
        }
      end
    end
  end

  private

  def update_contact_info_params
    params.require(:api_user).permit(:id, :contact_info)
  end

  private

  def register_params
    params.require(:api_user).permit(:password, :email, :phone, :full_name, :g_year, :kvkk_confirmed_date)
  end

  private

  def forgot_password_params
    params.require(:api_user).permit(:email)
  end

  private

  def update_user_info_params
    params.require(:api_user).permit(:id, :email, :phone, :job, :country, :about, :city)
  end

  private

  def update_password_params
    params.require(:api_user).permit(:id, :password)
  end

  private

  def search_user_params
    params.require(:api_user).permit(:id, :query)
  end
end
