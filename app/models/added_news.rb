class AddedNews < ApplicationRecord
  has_many_attached :images

  after_create :update_images_urls

  attr_accessor :sort_image

  def update_images_urls
    urls = self.images.map do |image|
      image.url
    end
    self.update(image_urls: urls)
  end

  def self.sort_image_urls(params)
    params[:image_ids].each_with_index do |image_id, index|
      ActiveStorage::Attachment.find_by(id: image_id).update(position: params[:sort_image][index])
    end
  end

  def self.search(params)
      AddedNews.where("LOWER(title) LIKE LOWER('%#{params[:query]}%')")
               .or(AddedNews.where("LOWER(description) LIKE LOWER('%#{params[:query]}%')"))
               .or(AddedNews.where("LOWER(context) LIKE LOWER('%#{params[:query]}%')"))
  end

  def self.result_modifier(res)
    res.as_json.each do |e|
      images_urls = ActiveStorage::Attachment.where(record_type: 'AddedNews', record_id: e['id'])
      if images_urls.any?
        array = []
        return_urls = images_urls.map do |image|
          puts image.blob.metadata
          array.push(AddedNews.find_aspect_ratio(image))
          image.url
        end
        e['image_urls'] = return_urls
        if (array.min < 0.8 )
          test_value = 0.8
        else
          test_value = array.min
        end
        e.merge!('aspect_ratio' => test_value)
      else
        case e['tag']
        when 'Vefat Haberi'
          puts 
          place_holder_url=[ENV['HOST'] + ActionController::Base.helpers.asset_url('place-holder-vefat.png')]
          e['image_urls'] = place_holder_url
        when 'Etkinlik'
          place_holder_url=[ENV['HOST'] + ActionController::Base.helpers.asset_url('place-holder-etkinlik.png')]
          e['image_urls'] = place_holder_url
        when 'Güzel Haber'
          place_holder_url=[ENV['HOST'] + ActionController::Base.helpers.asset_url('place-holder-guzel.png')]
          e['image_urls'] = place_holder_url
        end
        e.merge!('aspect_ratio' => 0.8)
      end
    end
  end

  def self.find_aspect_ratio(image)
    if image.analyzed? && image.blob.metadata['width'].to_i > 1
    ratio =  image.blob.metadata['width'].to_i / image.blob.metadata['height'].to_f
    ratio
    end
  end
end