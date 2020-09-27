FactoryBot.define do
  factory :news do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.sentence  }
  end
end
