class Parking < ApplicationRecord
  belongs_to :user
  has_many :orders, dependent: :destroy
  has_many :users, through: :orders


  validates :name, presence: true, length: { maximum: Settings.name_max },
    uniqueness: true
  validates :total_position, presence: true, numericality: { greater_than: Settings.total_position_min}
  validates :longitude, presence:true
  validates :latitude, presence:true
  validates :address, presence: true
  validates :price, presence: true, numericality: { greater_than: Settings.price_min}
end
