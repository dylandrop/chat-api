require "rails_helper"

describe SessionsController do
  describe '#create' do
    subject { post :create, params: params }
    let(:user) { build_stubbed(:user) }

    let(:params) do
      {
        user: {
          email: "a@b.c",
          password: "password"
        }
      }
    end

    context 'success' do
      specify do
        expect(User).to receive(:find_by).with(email: "a@b.c") {
          user
        }
        expect(user).to receive(:authenticate) { true }
        expect(JSON.parse(subject.body)['api_auth_token']).to be_present
      end
    end

    context 'bad password' do
      specify do
        expect(User).to receive(:find_by).with(email: "a@b.c") {
          user
        }
        expect(user).to receive(:authenticate) { false }
        expect(JSON.parse(subject.body)['errors']).to be_present
      end
    end
  end
end
