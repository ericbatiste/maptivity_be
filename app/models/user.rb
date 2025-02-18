class User < ApplicationRecord
  has_secure_password
  has_many :activities, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :refresh_token, uniqueness: true, allow_nil: true

  def generate_refresh_token
    self.refresh_token = SecureRandom.hex(32)
    save!
    refresh_token
  end

  def revoke_refresh_token
    update!(refresh_token: nil)
  end
end
