FactoryBot.define do
  factory :parking do
    name {"baidoxe"}
    description {"Chat luong tot"}
    total_position {50}
    avail_position {35}
    longitude {105.804817}
    latitude {21.028511}
    status {"Mở cửa"}
    address {"address test"}
    price {5}
  end
  factory :parking_test, class: Parking do
    id {1}
    name {"Bai do"}
    waiting_time {"30 phut"}
    description {"Chat luong tot"}
    total_position {100}
    avail_position {50}
    longitude {21.028511}
    latitude {105.804817}
    address {"Cau Giay, Ha Noi"}
    time_open {Time.now}
    time_close {Time.now}
    status {"Mở cửa"}
    price {200000}
  end

  factory :parking_test2, class: Parking do
    id {2}
    name {"Bai do 2"}
    waiting_time {"30 phut"}
    description {"Chat luong tot"}
    total_position {100}
    avail_position {100}
    longitude {21.028011}
    latitude {105.804017}
    address {"Cau Giay, Ha Noi"}
    time_open {Time.now}
    time_close {Time.now}
    status {"Mở cửa"}
    price {200000}
  end

  factory :invalid_parking_test, class: Parking do
    name {""}
    waiting_time {"50 phut"}
    description {"OK"}
    total_position {100}
    avail_position {50}
    longitude {21.028511}
    latitude {105.804817}
    address {""}
    time_open {"06:00".to_time}
    time_close {"01:00".to_time}
    price {200000}
  end
end
