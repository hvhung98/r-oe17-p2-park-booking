FactoryBot.define do
  factory :time_order do
    value {DateTime.now}
    style {"day"}
  end
end
