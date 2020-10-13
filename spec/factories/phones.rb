FactoryBot.define do
  factory :phone do
    value { Faker::PhoneNumber.phone_number }
  end
end
