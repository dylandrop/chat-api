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

  def self.create_for_users!(subject: nil, users:)
    create!(subject: subject).tap do |conversation|
      users.each do |user|
        conversation.users << user
      end
    end
  end
end
