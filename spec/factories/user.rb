FactoryBot.define do
  factory :user do
    name "Diogo"
    email {"#{name}@mail.com"}
    password "blahblah"
    admin true
    confirmed_at Time.now
  end
end
