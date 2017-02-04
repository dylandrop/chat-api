class MessagesController < ApplicationController
  before_action :fetch_current_user

  def index
    messages = load_messages
    return head(404) unless messages.present?
    render json: messages, status: 200, each_serializer: MessageSerializer
  end

  private

  def optional_params
    params.permit(:with, :subject)
  end

  def load_messages
    Message.eager_load(:conversation, :user)
      .merge(load_conversations)
  end

  def load_conversations
    conversations = fetch_current_user.conversations
    if optional_params.present?
      conversations = conversations.with(
        email: optional_params[:with],
        subject: optional_params[:subject]
      )
    end
    conversations
  end
end
