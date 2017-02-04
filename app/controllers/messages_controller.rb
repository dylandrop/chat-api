class MessagesController < ApplicationController
  before_action :fetch_current_user

  def index
    conversation = load_conversation
    return head(404) unless conversation.present?
    render json: conversation.messages, status: 200, each_serializer: MessageSerializer
  end

  private

  def required_params
    params.permit(:with, :subject)
  end

  def load_conversation
    fetch_current_user.conversations.with(
      email: required_params[:with],
      subject: required_params[:subject]
    ).first
  end
end
