class Role < ApplicationRecord
  has_many :users, dependent: :destroy
  has_one :time_order
  validates :name, presence: true
end
