require 'rails_helper'

RSpec.describe AuthenticateUser do
  let(:user) { create(:user) }
  # valid request subject
  subject(:valid_auth_obj) { described_class.new(user.email, user.password) }
  # invalid request subject
  subject(:invalid_auth_obj) { described_class.new('foo', 'bar') }

  describe '#call' do
    # return token with valid request
    context 'when credentials are valid' do
      it 'returns an auth token' do
        token = valid_auth_obj.call
        expect(token).not_to be_nil
      end
    end

    # rails Authentication Error when invalid request
    context 'when credentials are invalid' do
      it 'raises an authentications error' do
        expect { invalid_auth_obj.call }.to raise_error(ExceptionHandler::AuthenticationError, /Invalid Credentials/)
      end
    end
  end
end
