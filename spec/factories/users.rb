FactoryBot.define do
  factory :user do
    full_name { Faker::Name.name }
    group_number { "11-703" }
    phone_number { Faker::PhoneNumber.phone_number }
    email { Faker::Internet.email }
    password { "123456" }
  end
end
