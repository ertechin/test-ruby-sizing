class Api::V1::AddedNewsController < ApiController

  def take_news
    case params[:tag]
    when 'all'
      res = AddedNews.all
      @data = result_modifier(res)
    else
      res = AddedNews.where(tag: params[:tag])
      @data = result_modifier(res)
    end
  end

  def search_news
    res = AddedNews.search(params)
    @search_result = result_modifier(res)
  end

  def search_news_params
    params.require(:api_news).permit(:query)
  end

  def result_modifier(res)
    res.each do |e|
      images_urls = ActiveStorage::Attachment.where(record_type: 'AddedNews', record_id: e.id)
      if images_urls.any?
        return_urls = images_urls.map do |image|
          image.url
        end
        e.image_urls = return_urls
        res
      else
        res
      end
    end
  end
end
