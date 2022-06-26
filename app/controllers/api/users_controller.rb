class Api::UsersController < ApiController
  respond_to :json

  def upload_profile_image
    message = User.update_profile_image(request)
    respond_to do |format|
      format.json { render json: {
        status: 200,
        response_message: "Basarili",
        request_id: request.request_id
        }}
    end
  end
end
