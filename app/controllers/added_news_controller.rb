class AddedNewsController < ApplicationController
  before_action :set_added_news, only: [:show, :edit]

  def edit
    @images = @added_new.images
  end

  def sort_images
    @added_new = AddedNews.find(params[:id])
    AddedNews.sort_image_urls(params)
    redirect_to admin_added_news_path(@added_new.id)
  end

  def delete_image
    image = ActiveStorage::Attachment.find_by(id: params[:id])
    image.purge
    added_new = AddedNews.find(image.record_id)
    redirect_to edit_added_news_path(added_new.id)
  end

  private
  def set_added_news
    @added_new = AddedNews.find(params[:id])
  end
end
