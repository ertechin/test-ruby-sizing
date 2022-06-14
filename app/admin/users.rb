ActiveAdmin.register User do
  filter :fullname
  filter :email
  filter :phone
  filter :gyear

  actions :index, :show
  index do
    column "Name", :fullname
    column :email
    column :phone
    column :gyear
    column "Confirmed", :confirmed
    actions
  end

  show do
    attributes_table do
      row "Name" do |user|
        user.fullname
      end
      row :email
      row :phone
      row :gyear
      row "Confirmed" do |user|
        user.confirmed
      end
      panel "Onayla/Reddet" do
        columns do
          column do
            link_to "Onayla", confirm_admin_user_path(user)
          end
          column do
            link_to "Reddet", reject_admin_user_path(user)
          end
        end
      end
    end
  end

  # confirm_admin_user_path
  member_action :confirm, method: :get do
    user = User.find params[:id]
    user.send_confirmed_email if user.confirmed == false
    user.update(confirmed: true)
    redirect_to admin_users_path
  end

  member_action :reject, method: :get do
    redirect_to admin_users_path
  end

end
