require "rails_helper"

describe User do
  context 'validations' do
    let(:user) { User.new }

    describe 'name, email, password presence checks' do
      it 'fails for blank content' do
        user.valid?
        expect(user.errors[:email]).not_to be_blank
        expect(user.errors[:password_digest]).not_to be_blank
        expect(user.errors[:name]).not_to be_blank
      end
    end
  end
end
