class Conversation < ApplicationRecord
  has_many :users, through: :conversations_users
  has_many :messages
end
