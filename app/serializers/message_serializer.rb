class MessageSerializer < ActiveModel::Serializer
  attributes :content, :from, :subject

  def from
    object.user.email
  end

  def subject
    object.conversation.subject
  end
end
