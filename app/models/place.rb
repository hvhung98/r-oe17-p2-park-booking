class Place < ApplicationRecord
  validates :longitude, presence:true
  validates :latitude, presence:true
  scope :find_place, ->(lat, lng) {where latitude:
    lat[Settings.min_cr_cor..lat.index(".")+Settings.max_cr_cor],
    longitude: lng[Settings.min_cr_cor..lng.index(".")+Settings.max_cr_cor]}
end
