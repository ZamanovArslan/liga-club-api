FactoryBot.define do
  factory :user do
    full_name { Faker::Name.name }
    group_number { "11-703" }
    phone_number { Faker::PhoneNumber.phone_number }
    password { "123456" }
    university { association(:university) }
  end

  trait :with_avatar do
    avatar { Rack::Test::UploadedFile.new(File.join("spec/support/fixtures", "image.png")) }
  end
end
