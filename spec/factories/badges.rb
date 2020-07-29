FactoryBot.define do
  factory :badge do
    name { "Some help to elderly" }
    description { "Some help to elderly" }
    ends_at { Time.zone.now + 1.day }
    rarity { association(:rarity) }
    confirmation_method { :text }
  end

  trait :with_university do
    university { association(:university) }
  end

  trait :with_image do
    image { Rack::Test::UploadedFile.new(File.join("spec/support/fixtures", "image.png")) }
  end
end
