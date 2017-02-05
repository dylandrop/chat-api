require 'rails_helper'

RSpec.describe 'Make and see messages', type: :request do
  let!(:user) { create(:user, name: "Bob Smith") }
  let(:headers) do
    {
      'Content-Type' => 'application/json',
      'Authorization' => "Token token=#{user.api_auth_token}"
    }
  end
  let(:params) do
    {
      user: {
        email: email,
        password: password
      }
    }
  end

  before do
    user.regenerate_api_auth_token
  end

  context 'see all messages' do
    subject { get "/messages", params: nil, headers: headers }
    let!(:message) { create(:message, user: user, content: expected_content) }
    let(:expected_content) { "blah" }

    before do
      message.conversation.users << user
    end

    specify do
      subject
      json_response = JSON.parse(response.body)
      expect(json_response.first['content']).to eq(expected_content)
    end
  end
end
