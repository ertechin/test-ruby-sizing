class Api::SendedNewsController < ApiController
  respond_to :json

  def create_sended_news
    message = SendedNews.create_self(request)
    respond_to do |format|
      format.json { render json: {
        status: 200,
        response_message: "Basarili",
        request_id: request.request_id
        }}
    end
  end
end
