FactoryBot.define do
  factory :review do
    user_id {1}
    parking_id {2}
    rating {5}
    comment {"OK"}
  end
  factory :invalid_review, class: Review do
    user_id {1}
    parking_id {2}
    rating {4}
    comment {""}
  end
end
