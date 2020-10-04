FactoryBot.define do
  factory :university do
    name { "KPFU" }

    trait :with_city do
      city { association(:city) }
    end
  end
end
