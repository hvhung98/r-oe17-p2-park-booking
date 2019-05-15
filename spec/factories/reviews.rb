FactoryBot.define do
  factory :review do
    user_id {1}
    parking_id {1}
    rating {5}
    comment {"OK"}
  end
end
