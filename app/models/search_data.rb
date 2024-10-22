class SearchData < ApplicationRecord
  validates :location_name, presence: true
  validates :wind_speed, presence: true
  validates :wind_direction, presence: true
  validates :memo, length: { maximum: 65_535 }

  belongs_to :user

  def self.ransackable_attributes(auth_object = nil)
    [ "course_image", "created_at", "id", "location_name", "memo", "updated_at", "wind_direction", "wind_speed" ]
  end
end
