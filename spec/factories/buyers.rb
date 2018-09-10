FactoryBot.define do

  factory :buyer do
    firstname "Abuyer"
    lastname "Buyer"
    phone "07777777777"
    sequence(:email) { |n| "buyer#{n}@factory.com" }
    commrate 9
    after(:build)   { |b| b.skip_confirmation_notification! }
    after(:create)  { |b| b.confirm }
  end
end
