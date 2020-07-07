FactoryBot.define do
  factory :review do
    shelter

    title {Faker::Job.title}
    rating {Faker::Number.between(from: 0, to: 5)}
    content {Faker::Lorem.paragraph(sentence_count: 3)}
  end
end
