require "test_helper"

class MessageMailerTest < ActionMailer::TestCase

  test "Contact" do
    message = Message.new(
      name: 'Lima',
      email: 'lima@mail.com',
      body: 'Hello, my first mail.'
    )

    email = MessageMailer.contact(message)

    assert_emails 1 do
      email.deliver_now
    end

    assert_equal 'Message from worldcupbet.herokuapp.com', email.subject
    assert_equal [ENV['USER_EMAIL']], email.to
    assert_equal ['lima@mail.com'], email.from
    assert_equal "Name: Lima\nEmail: lima@mail.com\nHello, my first mail.", email.text_part.body.raw_source.strip.to_s

  end
end
