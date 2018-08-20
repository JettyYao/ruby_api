FactoryBot.define do
    factory :tag do
        tag_name { Faker::Lorem.word }
        created_by { Faker::StarWars.character }
    end
end