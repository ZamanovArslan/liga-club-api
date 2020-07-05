FactoryBot.define do
  factory :participation do
    trait :confirmed do
      confirmed { true }
    end
  end
end
