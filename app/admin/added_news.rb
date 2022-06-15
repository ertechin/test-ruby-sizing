ActiveAdmin.register AddedNews do
  permit_params :date, :context, :description, :title, :tag

  filter :context
  filter :title
  filter :tag

  index do
    column :date
    column :context
    column :title
    column :tag
    actions
  end

  form do |f|
    f.inputs "Added News Edit" do
      f.input :date, as: :datepicker,
                          datepicker_options: {
                            min_date: "1960-10-8"
                          }
      f.input :context, :as => :select, :collection => ["Güzel Haber", "Etkinlik", "Vefat Haberi"]
      f.input :description, as: :quill_editor
      f.input :title, as: :string
      f.input :tag
    end
    f.actions
  end


  show do
    attributes_table do
      row :date
      row :context
      row "Description" do
        added_news.description.html_safe
      end
      row :title
      row :tagg

      panel "Images" do
        columns do
          if added_news.images.present?
            added_news.images.each do |image|
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
