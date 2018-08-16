FactoryBot.define do
  factory :sale do
    house 
    date Time.now.to_date	
    notch 5
    minfee 5
  end
end
