class Parking < ApplicationRecord
  belongs_to :user
  has_many :orders, as: :orderable
  has_many :users, through: :orders
  has_many :reviews
  has_many :users, through: :reviews

  validates :name, presence: true, length: { maximum: Settings.name_max },
    uniqueness: true
  validates :total_position, presence: true, numericality: { greater_than: Settings.total_position_min}
  validates :longitude, presence: true
  validates :latitude, presence: true
  validates :address, presence: true
  validates :price, presence: true, numericality: { greater_than: Settings.price_min}
  scope :order_by_time, -> {order created_at: :desc}
  geocoded_by :address
end
