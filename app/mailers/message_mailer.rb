class MessageMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.message_mailer.contact.subject
  #
  def contact(message)
    @body = message.body
    @name = message.name
    @email = message.email
    mail to: ENV['USER_EMAIL'], from: message.email
  end
end
