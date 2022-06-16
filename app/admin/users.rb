ActiveAdmin.register User do
  filter :full_name
  filter :email
  filter :phone
  filter :g_year

  actions :index, :show
  index do
    column "Name", :full_name
    column :email
    column :phone
    column :g_year
    column "Confirmed", :is_confirmed
    column :is_deleted
    actions
  end

  show do
    attributes_table do
      row "Name" do |user|
        user.full_name
      end
      row :email
      row :phone
      row :g_year
      row "Confirmed" do |user|
        user.is_confirmed
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
    user.send_confirmed_email if user.is_confirmed == false
    user.update(is_confirmed: true)
    user.update(is_deleted: false)
    redirect_to admin_users_path
  end

  member_action :reject, method: :get do
    user = User.find params[:id]
    user.update(is_deleted: true)
    user.update(is_confirmed: false)
    redirect_to admin_users_path
  end

end
