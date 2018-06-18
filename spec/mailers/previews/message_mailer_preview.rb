# Preview all emails at http://localhost:3000/rails/mailers/message_mailer/
class MessageMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/message_mailer/contact
  def contact
    message = Message.new(
      name: 'Lima',
      email: 'lima@mail.com',
      body: "This is the body of the email. Great!"
    )

    MessageMailer.contact(message)
  end

end
