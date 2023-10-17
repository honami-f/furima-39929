FactoryBot.define do
  factory :item do
    name {'マグカップ'}
    description {'動物柄のマグカップです。'}
    price {'500'}
    category_id {2}
    condition_id {2}
    shipping_cost_id {2}
    prefecture_id {2}
    shipping_day_id {2}
    association :user 

    after(:build) do |item|
      item.image.attach(io: File.open('app/assets/images/test_image.png'), filename: 'test_image.png')
    end
  end
end