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

  private
  def set_added_news
    @added_new = AddedNews.find(params[:id])
  end
end
