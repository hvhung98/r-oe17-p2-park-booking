class Order < ApplicationRecord
  belongs_to :parking
  belongs_to :user

  validates :car_number, presence: true, uniqueness: true
  validates :type_booked, presence: true
  validates :price, presence: true, numericality: { greater_than: Settings.price_min}
end
