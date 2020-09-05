FactoryBot.define do
  factory :rarity do
    name { "Uncommon" }
    scores_count { rand(10) }
    color { "#ffffff" }
  end
end
