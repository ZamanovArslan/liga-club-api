FactoryBot.define do
  factory :participation do
    trait :approved do
      status { :approved }
    end
  end
end
