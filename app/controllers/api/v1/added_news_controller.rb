class Api::V1::AddedNewsController < ApiController
  include Pagy::Backend
  after_action { pagy_headers_merge(@pagy_a) if @pagy_a }
  def take_news
    case params[:tag]
    when 'all'
      res = AddedNews.all
      @pagy_a, @data = pagy_array(AddedNews.result_modifier(res))
    else
      res = AddedNews.where(tag: params[:tag])
      @pagy_a, @data = pagy_array(AddedNews.result_modifier(res))
    end
  end

  def search_news
    res = AddedNews.search(params)
    @search_result = AddedNews.result_modifier(res)
  end

  def search_news_params
    params.require(:api_news).permit(:query)
  end

  def send_notificaton_news
    @notification_news = AddedNews.find_notificaton_news(params)
  end
end
