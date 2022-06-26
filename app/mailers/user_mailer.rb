class UserMailer < ApplicationMailer
  default from: ENV["EMAIL_DOMAIN"]

  def confirm_email
    @user = params[:user]

    # @url = "#{root_url}/clinics/#{@user.clinic_id}/users/#{@user.id}/clinics_questions/#{@question.id}/edit"
    mail(to: @user.email, subject: "TAC Email Onaylandı")
  end

  def welcome_email
    @url = params[:url]
    mail(to: params[:user_email], subject: "TAC Mobile'a Hosgeldiniz")
  end

end
