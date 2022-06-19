class AddedNews < ApplicationRecord
  has_many_attached :images

  after_create :update_images_urls

  def update_images_urls
    urls = self.images.map do |image|
      image.url
    end
    self.update(image_urls: urls)
  end
end
