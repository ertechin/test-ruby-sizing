class Api::V1::SendedNewsController < ApiController
  respond_to :json

  def create_sended_news
    message = SendedNews.create_self(request)
    respond_to do |format|
      format.json { render json: {
        status: 200,
        response_message: "Success",
        request_id: request.request_id
        }}
    end
  end

  def get_images
    response = SendedNews.get_images(request)
    respond_to do |format|
      format.json { render json: {
        status: 200,
        response_message: "Success",
        response_body: response,
        request_id: request.request_id
        }}
    end
  end
end
