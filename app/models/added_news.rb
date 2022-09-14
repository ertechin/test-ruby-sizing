class AddedNews < ApplicationRecord
  include HTTParty

  has_many_attached :images

  after_create :update_images_urls

  after_save :send_news_notification

  attr_accessor :sort_image

  def update_images_urls
    urls = self.images.map do |image|
      image.url
    end
    self.update(image_urls: urls)
  end

  def send_news_notification
    case self.tag
    when 'Vefat Haberi'
      tag = 'bad'
    when 'Etkinlik'
      tag = 'event'
    when 'Güzel Haber'
      tag = 'good'
    end
    response = HTTParty.post(
      "https://fcm.googleapis.com/fcm/send",
      :body => {
        :data => {:id => self.id },
        :to => "/topics/#{tag}",
        :notification => {
          :body => self.description,
          :title => self.title
        }
      }.to_json,
      :headers => {'Content-Type' => 'application/json','Authorization' => ENV['FCM_KEY'] })
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
     AddedNews.result_modifier_single_data(e)
    end
  end
  
  def self.result_modifier_single_data(data)
    images_urls = AddedNews.find_attachment(data)
    data.image_urls = AddedNews.create_image_url(images_urls,data.tag)
    data
  end
  
  def self.find_attachment(data)
    ActiveStorage::Attachment.where(record_type: 'AddedNews', record_id: data.id)
  end

  def self.create_image_url(images_urls,tag)
    if images_urls.any?
      return_urls = images_urls.map do |image|
        image.url
      end
    else
      case tag
      when 'Vefat Haberi'
        place_holder_url=[ENV['HOST'] + ActionController::Base.helpers.asset_url('place-holder-vefat.png')]
      when 'Etkinlik'
        place_holder_url=[ENV['HOST'] + ActionController::Base.helpers.asset_url('place-holder-etkinlik.png')]
      when 'Güzel Haber'
        place_holder_url=[ENV['HOST'] + ActionController::Base.helpers.asset_url('place-holder-guzel.png')]
      end
    end
  end

  def self.find_notificaton_news(params)
    res = AddedNews.find_by(id: params[:id])
    AddedNews.result_modifier_single_data(res)
  end
end