class Api::V1::UsersController < ApiController
  skip_before_action :check_auth, :does_tokens_match, :only => [:register, :forgot_password]
  respond_to :json

  def login_with_token
    @current_user = current_user
  end
  
  def register
    @create_user_status = User.create_user(params)
  end

  def forgot_password
    @forgot_pw_which_json = User.forgot_password(params)
  end

  def update_user_info
    User.update_user(params)
  end

  def update_password
    User.update_pass(params)
  end

  def search_user
    user = User.find_by(id: params[:id])
    if user.contact_info
      @which_json = true
      @search_result = User.search(params)
    else
      @which_json = false
    end
  end

  def update_contact_info
    User.update_contact_info(params)
  end

  def upload_profile_image
    message = User.update_profile_image(request)
    respond_to do |format|
      format.json do
        render json: {
          status: 200,
          response_message: 'Success',
          request_id: request.request_id
        }
      end
    end
  end

  def send_email
    User.send_welcome_mail(params)
    respond_to do |format|
      format.json do
        render json: {
          status: 200,
          response_message: 'Success',
          request_id: request.request_id
        }
      end
    end
  end
end
