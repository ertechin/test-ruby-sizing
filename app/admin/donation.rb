ActiveAdmin.register Donation do
  permit_params :gyear, :class_count, :donate_count

  filter :gyear, label: "Mezuniyet Yılı"
  filter :class_count, label: "Mezun sayısı"
  filter :donate_count, label: "Aidat ödeyen sayısı"

  config.sort_order = 'gyear_asc'

  index do
    column "Mezuniyet Yılı", :gyear
    column "Mezun sayısı", :class_count
    column "Aidat ödeyen sayısı", :donate_count
    actions
  end

  show do
    attributes_table do
      row "Mezuniyet Yılı" do
        donation.gyear
      end

      row "Mezun sayısı" do
        donation.class_count
      end

      row "Aidat ödeyen sayısı" do
        donation.donate_count
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :gyear
      f.input :class_count
      f.input :donate_count
    end
    f.actions
  end

end
