require "rails_helper"

describe Message do
  context 'validations' do
    let(:message) { Message.new }

    describe 'content presence checks' do
      it 'fails for blank content' do
        message.valid?
        expect(message.errors[:content]).not_to be_blank
      end
    end

    describe 'relation presence checks' do
      it 'fails for blank content' do
        message.valid?
        expect(message.errors[:user]).not_to be_blank
        expect(message.errors[:conversation]).not_to be_blank
      end
    end
  end
end
