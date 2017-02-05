require "rails_helper"

describe MessageFactory do
  describe '.create' do
    subject do
      described_class.create(
        from: from,
        to_user_with_email: email,
        content: content,
        subject: conversation_subject
      )
    end
    let(:from) { build_stubbed(:user) }
    let(:content) { "Blahblahblah" }
    let(:email) { 'a@fds.com' }
    let(:conversation_subject) { 'I want to talk' }
    let(:conversation) { build_stubbed(:conversation) }

    before do
      allow(ApplicationRecord).to receive(:transaction).and_yield
    end

    context 'conversation already exists' do
      specify do
        expect(from).to receive(:conversations) { class_double(Conversation, with: [conversation]) }
        expect(Conversation).not_to receive(:create_for_users)
        expect(conversation).to receive(:messages) { class_double(Message, create: true) }
        expect(subject).to eq(true)
      end
    end

    context 'new conversation' do
      specify do
        expect(from).to receive(:conversations) { class_double(Conversation, with: []) }
        expect(Conversation).to receive(:create_for_users) { conversation }
        expect(User).to receive(:find_by!).with(email: email)
        expect(conversation).to receive(:messages) { class_double(Message, create: true) }
        expect(subject).to eq(true)
      end
    end
  end
end
