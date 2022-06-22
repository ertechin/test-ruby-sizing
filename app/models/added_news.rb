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
end
