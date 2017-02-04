class MessagesController < ApplicationController
  before_action :fetch_current_user

  def index
    messages = load_messages
    return head(404) unless messages.present?
    render json: messages, status: 200, each_serializer: MessageSerializer
  end

  private

  def required_params
    params.permit(:with, :subject)
  end

  def load_messages
    Message.eager_load(:conversation, :user)
      .merge(load_conversations)
  end

  def load_conversations
    fetch_current_user.conversations
      .with(
        email: required_params[:with],
        subject: required_params[:subject]
      )
  end
end
