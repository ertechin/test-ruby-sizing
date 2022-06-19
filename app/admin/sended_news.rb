ActiveAdmin.register SendedNews do
  menu label: "Geri Bildirimler"

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
          if sended_news.images.attached?
            sended_news.images.each do |image|
              column do
                link_to(image_tag(image, style: 'width:200px;'), url_for(image), download: "")
              end
            end
          end

        end
      end

    end
  end
end
