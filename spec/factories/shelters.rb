FactoryBot.define do
  factory :shelter do
    name { Faker::Company.name }
    address { Faker::Address.full_address }
    city { Faker::Address.city }
    state { Faker::Address.state_abbr }
    zip { Faker::Address.zip }
  end
end
