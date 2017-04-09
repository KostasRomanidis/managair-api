require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  let(:user) { build(:user) }
  let(:headers) { valid_headers.except('Authorization') }
  let(:valid_attributes) do
    attributes_for(:user, password_confirmation: user.password)
  end

  describe 'POST /v1/signup' do
    context 'when the request is valid' do
      before { post '/v1/signup', params: valid_attributes, headers: headers }

      it 'creates a new user' do
        expect(response).to have_http_status(201)
      end

      it 'returns success message' do
        logger.warn(json.pretty_inspect)
        expect(json['message']).to match(/Account created successfully/)
      end

      it 'returns an authentication token' do
        logger.warn(json.pretty_inspect)
        expect(json['auth_token']).not_to be_nil
      end
    end

    context 'when request is invalid' do
      before { post '/v1/signup', params: {}, headers: headers}

      it 'does not create a new user' do
        logger.warn(response.pretty_inspect)
        expect(response).to have_http_status(422)
      end

      it 'returns failure message' do
        expect(json['message']).to match(/Unprocessable entity/)
      end
    end
  end
end
