FactoryBot.define do
  factory :item do
    product              {Faker::Commerce.product_name}
    product_description  {Faker::Lorem.paragraph}
    category_id          {Faker::Number.between(from: 2, to: 11)}
    status_id            {Faker::Number.between(from: 2, to: 7)}
    cost_id              {Faker::Number.between(from: 2, to: 3)}
    prefecture_id        {Faker::Number.between(from: 2, to: 48)}
    shipping_day_id      {Faker::Number.between(from: 2, to: 4)}
    price                {Faker::Number.between(from: 2, to: 9999999)}
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end