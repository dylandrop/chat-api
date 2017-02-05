require 'rails_helper'

RSpec.describe 'Sign in and get auth token', type: :request do
  subject { post "/sessions", params: params, headers: headers }
  let!(:user) { create(:user, email: email, password: password, name: "Bob Smith") }
  let(:email) { 'a@b.c' }
  let(:password) { 'password' }
  let(:headers) { ['Content-Type: application/json'] }
  let(:params) do
    {
      user: {
        email: email,
        password: password
      }
    }
  end

  specify do
    subject
    json_response = JSON.parse(response.body)
    expect(json_response['api_auth_token']).to be_present
    expect(user.reload.api_auth_token).to eq(json_response['api_auth_token'])
  end
end
