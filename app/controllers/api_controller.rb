class ApiController < ApplicationController
  before_action :set_current_user, if: :json_request?
  before_action :check_auth
  before_action :check_format

  private
  # Use api_user Devise scope for JSON access
  def authenticate_user!(*args)
    super and return unless args.blank?
    json_request? ? authenticate_api_user! : super
  end

  # So we can use Pundit policies for api_users
  def set_current_user
    @current_user ||= warden.authenticate(scope: :api_user)
  end

  def check_auth
    auth_hash = request.headers["Authorization"]
    token = JWT.decode(auth_hash, ENV["DEVISE_JWT_SECRET_KEY"]) rescue nil
    if token.nil?
      respond_to do |format|
        format.json { render json: {
          status: 401,
          response_message: t("devise.sessions.unauthorized"),
          request_id: request.request_id
          }
        }
      end
    else
      @current_user = User.find_by_jti(token[0].first)
    end
  end

  def check_format
    if request.format != :json
      respond_to do |format|
        format.json { render json: {
          status: 406,
          response_message: "JSON requests only.",
          request_id: request.request_id
          }
        }
      end
    end
  end


end