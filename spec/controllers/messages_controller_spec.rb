require "rails_helper"

describe MessagesController do
  before do
    allow_any_instance_of(MessagesController)
      .to receive(:fetch_current_user)
      .and_return(user)
  end

  let(:user) { User.new }

  describe '#index' do
    subject { get :index }

    context 'no messages found' do
      let(:messages) { double(Message, merge: []) }

      specify do
        expect(Message).to receive(:eager_load).and_return(messages)
        expect(subject.status).to eq(404)
      end
    end

    context 'messages found' do
      let(:message) { Message.new }
      let(:messages) { double(Message, merge: [message]) }
      before do
        message.content = "First message"
        message.user = User.new(email: "test@test123.com")
        message.conversation = Conversation.new(subject: "Hey")
      end

      specify do
        expect(Message).to receive(:eager_load).and_return(messages)
        expect(subject.status).to eq(200)
        json_response = JSON.parse(response.body)
        expect(json_response).to be_an(Array)
        message = json_response.first
        expect(message["content"]).to eq("First message")
        expect(message["from"]).to eq("test@test123.com")
        expect(message["subject"]).to eq("Hey")
      end
    end
  end
end