FactoryBot.define do
  factory :item do
    name          {Faker::Lorem.characters(number: 6, min_alpha: 1, min_numeric: 1) }
    price         {Faker::Number.between(from: 300, to: 9999999)}
    content       {Faker::Lorem.characters(number: 6, min_alpha: 1, min_numeric: 1) }
    category_id   {1}
    condition_id  {1}
    fee_id        {1}
    prefecture_id {1}
    ship_day_id   {1}
    
    association :user
    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
