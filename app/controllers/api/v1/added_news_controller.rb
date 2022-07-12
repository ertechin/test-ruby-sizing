class Api::V1::AddedNewsController < ApiController

  def take_news
    case params[:tag]
    when 'all'
      @data = AddedNews.all
    else
      @data = AddedNews.where(tag: params[:tag])
    end
  end

  def search_news
    @search_result = AddedNews.search(search_news_params)
  end

  def search_news_params
    params.require(:api_news).permit(:query)
  end
end
