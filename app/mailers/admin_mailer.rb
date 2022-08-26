class AdminMailer < ApplicationMailer

  def after_user_confirm_email(current_user)
    @current_user = current_user
    admin_mail_list = AdminUser.take_all_admins_email
    mail(to: admin_mail_list, subject: "TAC: Yeni bir kullanıcı e-mailini onayladı.")
  end

  def after_user_delete_account(user_comment)
    @user_comment = user_comment
    admin_mail_list = AdminUser.take_all_admins_email
    mail(to: admin_mail_list, subject:'Bir kullanıcı hesabını sildi')
  end
end
