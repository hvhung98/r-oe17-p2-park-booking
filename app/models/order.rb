class Order < ApplicationRecord
  belongs_to :parking
  belongs_to :user
  validates :status, presence: true
  validates :price, presence: true
  validates :price, presence: true, numericality: { greater_than: Settings.price_min}
end
