ActiveAdmin.register AddedNews do
  permit_params :date, :context, :description, :title, :tag, images: []
  menu label: "Duyurular"

  filter :context
  filter :title
  filter :tag

  after_update do |news|
    news.update_images_urls
  end

  index do
    column :title
    column :description
    column :date
    column :tag
    actions
  end

  form do |f|
    f.inputs "Duyurular Edit" do
      f.input :tag, :as => :select, :collection => ["Güzel Haber", "Etkinlik", "Vefat Haberi"]
      f.input :title, as: :string
      f.input :description, as: :text
      f.input :date, as: :datepicker,
                          datepicker_options: {
                            min_date: "1960-10-8"
                          }
      f.input :context, as: :quill_editor
      f.input :images, as: :file, input_html: { multiple: true }
    end
    f.actions
  end


  show do
    attributes_table do
      row :tag
      row :title
      row :description
      row :date
      row "Context" do
        added_news.context.html_safe
      end

      panel "Images" do
        columns do
          if added_news.images.present?
            added_news.images.each do |image|
              column do
                link_to(image_tag(image, style: 'width:200px;'), url_for(image), download: "")
              end
            end
          end

        end
      end # Panel

    end
  end
end
