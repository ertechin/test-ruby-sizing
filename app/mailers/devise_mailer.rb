class DeviseMailer < Devise::Mailer
    def confirmation_instructions(record, token, opts={})
      mail = super
      mail.subject = "#{@resource.full_name}'#{@resource.g_year} :Lütfen e-posta adresini doğrula"
      mail
    end
  end