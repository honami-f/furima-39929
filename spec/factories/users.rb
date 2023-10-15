FactoryBot.define do
  factory :user do
    nickname              {Faker::Name.initials}
    email                 {Faker::Internet.email}
    password              { "a1" + Faker::Internet.password(min_length: 6) }
    password_confirmation {password}
    first_name            {Faker::Name.first_name}
    last_name             {Faker::Name.last_name}
    last_name_kana        {Faker::Name.first_name}
    first_name_kana       {Faker::Name.last_name}
    birthday              {Faker::Date.between(from: '1930-01-01', to: '2017-12-31')}
  end
end