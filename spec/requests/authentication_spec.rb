require 'rails_helper'

RSpec.describe 'Authentication', type: :request do
  # Authenication test suite
  describe 'POST /auth/login' do
    let!(:user) { create(:user) }
    let(:headers) { valid_headers.except('Authorization') }
    let(:valid_credentials) do
      {
        email: user.email,
        password: user.password
      }
    end
    let(:invalid_credentials) do
      {
        email: Faker::Internet.email,
        password: Faker::Internet.password
      }
    end

    # returns auth token when request is valid
    context 'when request is valid' do
      before { post '/auth/login', params: valid_credentials, headers: headers }

      it 'returns an authentication token' do
        logger.warn(json['auth_token'].pretty_inspect)
        expect(json['auth_token']).not_to be_nil
      end
    end

    # returns failure message when request is invalid
    context 'when request is invalid' do
      before { post '/auth/login', params: invalid_credentials, headers: headers }

      it 'returns a failure message' do
        expect(json['message']).to match(/Invalid Credentials/)
        logger.warn(json.pretty_inspect)
      end

      it 'returns a status code 401' do
        expect(response).to have_http_status(401)
      end
    end
  end
end
