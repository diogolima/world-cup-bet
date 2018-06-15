require 'test_helper'

class MessageTest < ActiveSupport::TestCase

  test 'responds to name, email, body' do
    msg = Message.new
    assert msg.respond_to?(:name), 'does not respond to :name'
    assert msg.respond_to?(:email), 'does not respond to :email'
    assert msg.respond_to?(:body), 'does not respond to :body'
  end

  test 'valid with all attributes' do
    attrs = {
      name: 'Diogo',
      email: 'my@mail.com',
      body: 'My body email'
    }

    msg = Message.new attrs
    assert msg.valid?, 'should be valid'
  end

  test 'required all params' do
    msg = Message.new
    refute msg.valid?, 'Blank Message should not be valid'

    assert_match /blank/, msg.errors[:name].to_s
    assert_match /blank/, msg.errors[:email].to_s
    assert_match /blank/, msg.errors[:body].to_s
  end
end
