class UserMailer < ApplicationMailer
  default from: ENV["EMAIL_DOMAIN"]

  def confirm_email
    @user = params[:user]

    # @url = "#{root_url}/clinics/#{@user.clinic_id}/users/#{@user.id}/clinics_questions/#{@question.id}/edit"
    mail(to: @user.email, subject: "TAC Email Onaylandı")
  end

end
