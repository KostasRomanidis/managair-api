module ControllerSpecHelper
  # generates tokens from user id
  def token_generator(user_id)
    JsonWebToken.encode(user_id: user_id)
  end

  # generates expired tokens from user id
  def expired_token_generator(user_id)
    JsonWebToken.encode({ user_id: user_id }, (Time.now.to_i - 10))
  end

  # return valid headers
  def valid_headers
    {
      "Authorization" => token_generator(user.id),
      "HTTP_ACCEPT" => 'application/json; version=1'
    }
  end

  # return invalid headers
  def invalid_headers
    {
      "Authorization" => nil,
      "HTTP_ACCEPT" => 'application/json; version=1'
    }
  end
end
