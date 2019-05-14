class TimeOrder < ApplicationRecord
  belongs_to :order
  validates :type, presence: true
  validates :value, presence: true

end
