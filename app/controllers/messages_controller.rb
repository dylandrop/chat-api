class MessagesController < ApplicationController
  before_action :fetch_current_user

  def index
    puts fetch_current_user.email
  end
end
