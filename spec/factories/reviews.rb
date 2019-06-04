FactoryBot.define do
  factory :review do
    user { nil }
    parking { nil }
    rating { 1 }
    comment { "MyText" }
  end
end
