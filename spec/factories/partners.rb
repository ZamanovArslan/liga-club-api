FactoryBot.define do
  factory :partner do
    name { Faker::Company.name }
    description { Faker::Company.catch_phrase }
    discount { 50 }
    instagram_link { "https://www.instagram.com/unicsbasket/" }
  end
end
