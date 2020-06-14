FactoryBot.define do
  factory :level do
    name { "Первак" }
    scores_count { rand(10) }
    description { "Первый уровень" }
  end
end
