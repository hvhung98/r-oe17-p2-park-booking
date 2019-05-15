FactoryBot.define do
  factory :user do
    id {1}
    name {"admin123"}
    email {"admin123@gmail.com"}
    score {10}
    phone_number {"0963740311"}
    role_id {1}
    password {"vvqvvq"}
    password_confirmation {"vvqvvq"}
  end
end
