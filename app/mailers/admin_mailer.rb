class AdminMailer < ApplicationMailer

  def after_user_confirm_email(current_user)
    @current_user = current_user
    admin_mail_list = AdminUser.take_all_admins_email
    mail(to: admin_mail_list, subject: "TAC: Yeni bir kullanıcı e-mailini onayladı.")
  end
end
