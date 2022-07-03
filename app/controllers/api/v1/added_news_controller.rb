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
    @search_result = AddedNews.search(params)
  end
end
