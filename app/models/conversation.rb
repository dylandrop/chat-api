class Conversation < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :messages

  def self.with(email:, subject: nil)
    conversations = joins(:users).where(users: { email: email })
    if subject.present?
      conversations = conversations.where(subject: subject)
    end
    conversations
  end
end
