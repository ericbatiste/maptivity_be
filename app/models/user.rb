class User < ApplicationRecord
  has_many :activities, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
end
