class SendedNews < ApplicationRecord
  has_many_attached :images

  validate :acceptable_image

  after_create :update_images_urls

  def update_images_urls
    urls = self.images.map do |image|
      image.url
    end
    self.update(image_urls: urls)
  end

  def self.create_self(params)
    news = SendedNews.new(
                          context: params[:context],
                          description: params[:description],
                          title: params[:title],
                          tag: params[:tag],
                          date: params[:date],
                          user_name: params[:user_name],
                          user_gyear: params[:user_gyear]
                        )
    news.images.attach(params[:images])
    news.save!
  end

  def acceptable_image
    return unless images.attached?

    images.each do |image|
      unless image.byte_size <= 1.megabyte
        errors.add(:images, "is too big")
      end
    end

    acceptable_types = ["image/jpeg", "image/png"]
    images.each do |image|
      unless acceptable_types.include?(image.content_type)
        errors.add(:images, "must be a JPEG or PNG")
      end
    end
  end
end
