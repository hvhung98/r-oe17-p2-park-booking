class Place < ApplicationRecord
  validates :longitude, presence:true
  validates :latitude, presence:true
  scope :find_place, ->(lat, lng) {where latitude: lat[0..lat.index(".")+7],
    longitude: lng[0..lng.index(".")+7]}
end
