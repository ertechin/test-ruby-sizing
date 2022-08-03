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
    column "Verified" do |user|
      user.verified unless user.verified.nil?
    end
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
      row "Verified" do |user|
        user.verified unless user.verified.nil?
      end
      panel "Onayla/Reddet" do
        columns do
          if user.confirmed?
            column do
              link_to "Onayla", confirm_admin_user_path(user)
            end
            column do
              link_to "Reddet", reject_admin_user_path(user)
            end
          else
            column do
              "Kullanıcı henüz onaylanmadı."
            end
          end
        end
      end
    end
  end

  # confirm_admin_user_path
  member_action :confirm, method: :get do
    user = User.find params[:id]
    user.send_verified_email
    user.update(verified: true)
    user.update(is_deleted: false)
    redirect_to admin_users_path
  end

  member_action :reject, method: :get do
    user = User.find params[:id]
    user.send_reject_email
    user.update(is_deleted: true)
    user.update(verified: false)
    redirect_to admin_users_path
  end

end
