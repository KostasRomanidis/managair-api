class JsonWebToken
  # secret to encode and decode token
  HMAC_SECRET = Rails.application.secrets.secret_key_base

  # Encode a hash in a json web token.
  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, HMAC_SECRET)
  end

  # Decode the token and return the payload inside
  def self.decode(token)
    body = JWT.decode(token, HMAC_SECRET)[0]
    HashWithIndifferentAccess.new body
    # rescue from expirity exception
  rescue JWT::ExpiredSignature, JWT::VerificationError => e
    raise ExceptionHandler::InvalidToken, e.message
  end
end
