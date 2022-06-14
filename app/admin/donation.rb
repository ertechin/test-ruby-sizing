ActiveAdmin.register Donation do
  permit_params :gyear, :class_count, :donate_count

  filter :gyear
  filter :class_count
  filter :donate_count

  config.sort_order = 'gyear_asc'

  actions :index, :edit, :show

  index do
    column :gyear
    column :class_count
    column :donate_count
    actions
  end

  show do
    attributes_table do
      row :gyear
      row :class_count
      row :donate_count
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
