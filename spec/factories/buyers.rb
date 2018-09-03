FactoryBot.define do

	sequence :email do |n|
	  "buyer#{n}@factory.com"
	end

  factory :buyer do
    firstname "A"
    lastname "B"
    phone "07777777777"
    email
    commrate 9
    after(:build)   { |b| b.skip_confirmation_notification! }
    after(:create)  { |b| b.confirm }
  end
end
