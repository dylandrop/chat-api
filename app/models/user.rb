class User < ApplicationRecord
  has_secure_password
  has_secure_token :api_auth_token

  has_many :conversations, through: :conversations_users
  has_many :messages

  validates :name, :email, presence: true
end
