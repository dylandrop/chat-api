class User < ApplicationRecord
  devise :database_authenticatable

  has_many :conversations, through: :conversations_users
  has_many :messages

  validates :name, :email, :encrypted_password, presence: true
end
