FactoryBot.define do
  factory :seller do
    firstname "J"
    lastname "T"
    email "jt@jt.com"
    phone "07896777777"
    commrate 9
    after(:build)   { |s| s.skip_confirmation_notification! }
    after(:create)  { |s| s.confirm }
  end
end
