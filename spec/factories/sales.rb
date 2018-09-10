FactoryBot.define do
  factory :sale do
    house 
    date 7.days.ago	
    notch 5
    minfee 5
    active false
    complete false
  end
end
