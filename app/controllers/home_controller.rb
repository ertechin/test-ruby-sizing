class HomeController < ApplicationController

  def index
    redirect_to admin_user_session_path
  end

end
