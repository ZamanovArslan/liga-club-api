FactoryBot.define do
  factory :badge do
    name { "Some help to elderly" }
    description { "Some help to elderly" }
    ends_at { Time.zone.now + 1.day }
    rarity { association(:rarity) }
  end

  trait :with_university do
    university { association(:university) }
  end
end
