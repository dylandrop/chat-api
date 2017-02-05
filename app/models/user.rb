class User < ApplicationRecord
  has_secure_password
  has_secure_token :api_auth_token

  has_and_belongs_to_many :conversations
  has_many :messages

  validates :name, :email, :password, presence: true
end
