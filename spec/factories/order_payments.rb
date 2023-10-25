FactoryBot.define do
  factory :order_payment do
    token { 'tok_abcdefghijk00000000000000000' }
    post_code { '000-0000' }
    prefecture_id { 2 }
    city { '札幌市' }
    street_address { '札幌1−1' }
    building { '102' }
    phone_number { '09012345678' }
  end
end
