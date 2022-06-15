ActiveAdmin.register SendedNews do
  filter :context
  filter :title
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
          if sended_news.images.present?
            sended_news.images.each do |image|
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
end
