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
    res.each do |e|
      images_urls = ActiveStorage::Attachment.where(record_type: 'AddedNews', record_id: e.id)
      if images_urls.any?
        return_urls = images_urls.map do |image|
          image.variant(saver: { quality: 5 }).url
        end
        e.image_urls = return_urls
        res
      else
        res
      end
    end
  end
end