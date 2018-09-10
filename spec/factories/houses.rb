FactoryBot.define do

  factory :house do
    name "MyString"
    code "aa"
    address1 "MyString"
    address2 "MyString"
    address3 "MyString"
    postcode "MyString"
    phone "01234123456"
    sequence(:email) { |n| "house#{n}@factory.com" }
  end
end
