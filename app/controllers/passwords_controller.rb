class PasswordsController < Devise::PasswordsController
    respond_to :json, only: [:create]
  
    def create
      user = User.send_reset_password_instructions(params.fetch(:user))
      if successfully_sent?(user)
        render json: { internal_api_status: 'ok' }, status: 200
      else
        render json: { internal_api_status: 'reset_password_instructions_cant_send' }, status: 400
      end
    end

    def after_resetting_password_path_for(resource)
      reset_password_completed_path
    end
end
  