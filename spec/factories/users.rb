FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    group_number { "11-703" }
    phone { association(:phone) }
    password { "123456" }
    university { association(:university) }
  end

  trait :with_avatar do
    avatar { Rack::Test::UploadedFile.new(File.join("spec/support/fixtures", "image.png")) }
  end
end
