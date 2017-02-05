class MessageFactory
  def initialize(from:, to_user_with_email:, content:, subject: nil)
    @from = from
    @to_user_with_email = to_user_with_email
    @content = content
    @subject = subject
  end

  def self.create(args)
    new(args).create
  end

  def create
    ApplicationRecord.transaction do
      conversation = load_conversation || create_new_conversation!
      create_message_in_conversation(conversation)
    end
  end

  private

  attr_reader :from, :to_user_with_email, :content, :subject

  def load_conversation
    conversations = from.conversations.with(
      email: to_user_with_email, subject: subject
    ).first
  end

  def create_new_conversation!
    Conversation.create_for_users!(
      subject: subject,
      users: [from, User.find_by!(email: to_user_with_email)]
    )
  end

  def create_message_in_conversation(conversation)
    conversation.messages.create!(
      user: from,
      content: content
    )
  end
end
