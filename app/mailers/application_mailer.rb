class ApplicationMailer < ActionMailer::Base
  default from: email_address_with_name(ENV["EMAIL_DOMAIN"], "TAC Mezun Mobil")
  layout "mailer"
end
