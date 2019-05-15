FactoryBot.define do
  factory :order do
    user_id {2}
    car_number {"33H1-8666"}
    orderable_type {"Parking"}
    orderable_id {1}
    type_booked {"Đặt theo ngày"}
    day_booked {Time.now}
    price {200000}
  end

  factory :order2, class: Order do
    user_id {1}
    car_number {"18G1-12345"}
    orderable_type {"Parking"}
    orderable_id {2}
    type_booked {"Đặt theo ngày"}
    day_booked {Time.now}
    price {200000}
  end

  factory :order3, class: Order do
    user_id {1}
    car_number {"18G1-12345"}
    orderable_type {"Parking"}
    orderable_id {2}
    type_booked {"Đặt theo ngày"}
    day_booked {Time.now + 10.days}
    price {200000}
  end
end
