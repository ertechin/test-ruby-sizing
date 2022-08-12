class HomeController < ApplicationController

  def index
    redirect_to admin_user_session_path
  end
  def after_confirmation_path
    AdminMailer.after_user_confirm_email(current_user).deliver_now
  end
  def completed_reset_password_path
  end
end
