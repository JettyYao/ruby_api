FactoryBot.define do
    factory :new do
      content { Faker::Lorem.sentence}
    end
  end