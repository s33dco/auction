FactoryBot.define do

  factory :auctioneer do
    name "Jake"
    email "auctioneer@factory.com"
    after(:build)   { |a| a.skip_confirmation_notification! }
    after(:create)  { |a| a.confirm }
  end
end
