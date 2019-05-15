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
  factory :user2, class: User do
    id {2}
    name {"hoanghung123"}
    email {"hoanghung123@gmail.com"}
    score {10}
    phone_number {"0972995963"}
    password {"123456"}
    password_confirmation {"123456"}
  end
end
