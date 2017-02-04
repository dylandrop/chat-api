class MessagesController < ApplicationController
  before_action :fetch_current_user

  def index
    messages = load_messages
    return head(404) unless messages.present?
    render json: messages, status: 200, each_serializer: MessageSerializer
  end

  def create
    message = MessageFactory.create(
      from: fetch_current_user,
      to_user_with_email: message_creation_params[:to_user_with_email],
      subject: message_creation_params[:subject],
      content: message_creation_params[:content]
    )

    if message
      render json: message, status: :created
    else
      head(400)
    end
  end

  private

  def optional_get_params
    params.permit(:with, :subject)
  end

  def message_creation_params
    params.require(:message).permit(
      :to_user_with_email, :subject, :content
    )
  end

  def load_messages
    Message.eager_load(:conversation, :user)
      .merge(load_conversations)
  end

  def load_conversations
    conversations = fetch_current_user.conversations
    if optional_get_params.present?
      conversations = conversations.with(
        email: optional_get_params[:with],
        subject: optional_get_params[:subject]
      )
    end
    conversations
  end
end
