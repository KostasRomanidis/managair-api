require 'jwt'

module AuthToken
  ALGORITHM = 'HS256'
  # Encode a hash in a json web token.
  def self.encode(payload)
    JWT.encode(payload, auth_secret, ALGORITHM)
  end

  # Decode the token and return the payload inside
  def self.decode(token)
    body = JWT.decode(token, auth_secret).first
    HashWithIndifferentAccess.new body
  rescue
    nil
  end

  def self.auth_secret
    ENV["AUTH_SECRET"]
  end
end
