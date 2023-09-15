FactoryBot.define do
  factory :item do
    name          {Faker::Lorem.characters(number: 6, min_alpha: 1, min_numeric: 1) }
    price         {Faker::Number.between(from: 300, to: 9999999)}
    content       {Faker::Lorem.characters(number: 6, min_alpha: 1, min_numeric: 1) }
    category      {Category.all.sample}
    condition     {Condition.all.sample}
    fee           {Fee.all.sample}
    prefecture    {Prefecture.all.sample}
    ship_day      {ShipDay.all.sample}
    
    association :user
    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
