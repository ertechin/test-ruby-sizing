ActiveAdmin.register AddedNews do
  permit_params :date, :context, :description, :title, :tag, :images
  menu label: "Duyurular"

  filter :context
  filter :title
  filter :tag

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
      f.input :images
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
              unless image.nil?
                column do
                  link_to(image_tag("https://tac-mobile.herokuapp.com/newsPhotos/" + image, style: 'height:100px;width:100px;'),
                  "https://tac-mobile.herokuapp.com/newsPhotos/" + image, download: "#{image}")
                end
              end
            end
          end
        end
      end

    end
  end
end
