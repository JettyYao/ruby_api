FactoryBot.define do
  factory :post do
    title { Faker::Lorem.word}
    author { Faker::StarWars.character }
    content { Faker::Lorem.sentence}
  end
end