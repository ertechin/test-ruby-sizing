class Api::V1::AddedNewsController < ApiController

  def take_news
    case params[:tag]
    when 'all'
      res = AddedNews.all
      @data = AddedNews.result_modifier(res)
    else
      res = AddedNews.where(tag: params[:tag])
      @data = AddedNews.result_modifier(res)
    end
  end

  def search_news
    res = AddedNews.search(params)
    @search_result = AddedNews.result_modifier(res)
  end

  def search_news_params
    params.require(:api_news).permit(:query)
  end
end
