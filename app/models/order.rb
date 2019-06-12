class Order < ApplicationRecord
  enum status: [:booked, :sending, :sended, :canceled]
  belongs_to :user
  belongs_to :orderable, polymorphic: true
  validates :status, presence: true
  validates :car_number, presence: true
  validates :type_booked, presence: true
  validates :price, presence: true, numericality: {greater_than: Settings.price_min}
  scope :find_order, ->(id, type) {where orderable_id: id, orderable_type: type}
  scope :find_status, ->(status) {where status: status}
  scope :order_by_time, -> {order created_at: :desc}
end
