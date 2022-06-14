ActiveAdmin.register SendedNews do
  filter :context
  filter :title
  filter :phone
  filter :tag

  actions :index, :show
  index do
    column :context
    column :description
    column :title
    column :tag
    actions
  end

  show do
    attributes_table do
      row :context
      row :description
      row :title
      row :tag

      panel "Images" do
        columns do
          sended_news.images.slice(1..-2).split(",").each do |image|
            column do
              link_to(image_tag("https://tac-mobile.herokuapp.com/newsPhotos/" + image),
              "https://tac-mobile.herokuapp.com/newsPhotos/" + image, download: "#{image}")
            end
          end

        end
      end

    end
  end
end
