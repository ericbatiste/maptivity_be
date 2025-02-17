class Activity < ApplicationRecord
  belongs_to :user

  validates :title, :designation, :start_time, :end_time, :route, presence: true
  validates :distance, :max_speed, :average_speed, :climbing, :descending, numericality: { greater_than_or_equal_to: 0 }
end
