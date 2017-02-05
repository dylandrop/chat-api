require "rails_helper"

describe Conversation do
  describe '.with' do
    let(:email) { 'a@b.c' }
    let(:returned_scope) { class_double(described_class) }

    subject do
      described_class.with(
        email: email,
        subject: conversation_subject
      )
    end

    context 'when only email provided' do
      let(:conversation_subject) { nil }

      specify do
        expect(described_class).to receive(:joins)
          .and_return(returned_scope)
        expect(returned_scope).to receive(:where)
          .with(users: { email: email })
          .and_return(returned_scope)
        result = subject
        expect(result).to eq(returned_scope)
      end
    end

    context 'when subject provided as well' do
      let(:conversation_subject) { "Just a conversation" }
      let(:other_scope) { class_double(described_class) }

      specify do
        expect(described_class).to receive(:joins)
          .and_return(returned_scope)
        expect(returned_scope).to receive(:where)
          .with(users: { email: email })
          .and_return(other_scope)
        expect(other_scope).to receive(:where)
          .with(subject: conversation_subject)
          .and_return(other_scope)
        result = subject
        expect(result).to eq(other_scope)
      end
    end
  end

  describe '.create_for_users!' do
    let(:users) { [user1, user2] }
    let(:user1) { build_stubbed(:user) }
    let(:user2) { build_stubbed(:user) }
    let(:conversation_subject) { "Just a conversation" }
    let(:newly_created_conversation) { build_stubbed(:conversation) }

    subject do
      described_class.create_for_users!(
        subject: conversation_subject,
        users: users
      )
    end

    specify do
      expect(described_class)
        .to receive(:create!)
        .with(subject: conversation_subject)
        .and_return(newly_created_conversation)
      result = subject
      expect(result).to be_a(described_class)
      expect(result.users).to eq(users)
    end
  end
end
