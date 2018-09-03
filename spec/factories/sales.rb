FactoryBot.define do
  factory :sale do
    house 
    date Time.now.to_date	
    notch 5
    minfee 5
    active true
  end
end
