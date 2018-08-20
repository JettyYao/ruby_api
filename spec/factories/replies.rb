FactoryBot.define do
    factory :reply do
      username { Faker::StarWars.character}
      account { Faker::Internet.email }
      content { Faker::Lorem.sentence}
    end
  end