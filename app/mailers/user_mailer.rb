class UserMailer < ApplicationMailer
  default from: ENV["EMAIL_DOMAIN"]

  def verified_email
    @user = params[:user]

    mail(to: @user.email, subject: "#{@user.full_name}'#{@user.g_year} : TAC Mezun Mobil kaydınız onaylandı")
  end

  def reject_email
    @user = params[:user]

    mail(to: @user.email, subject: "#{@user.full_name}'#{@user.g_year} : TAC Mezun Mobil kaydınız onaylanmadı")
  end

  def welcome_email
    @url = params[:url]
    mail(to: params[:user_email], subject: "TAC Mobile'a Hosgeldiniz")
  end

  def forgot_password_email
    mail(to: params[:email], subject: "TAC Mobile Yeni Şifreniz")
  end

end
