FactoryBot.define do
  factory :applicant do
    name { Faker::Name.full_name }
    address { Faker::Address.full_address }
    city { Faker::Address.city }
    state { Faker::Address.state_abbr }
    zip { Faker::Address.zip }
    phonenumber { "MyString" }
    description { Faker::Lorem.paragraph(sentence_count: 3) }
  end
end
