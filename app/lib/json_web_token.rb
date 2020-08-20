module JsonWebToken
  SECRET = Rails.application.credentials.secret_key_base

  def encode_token(payload)
    JWT.encode(payload, SECRET)
  end

  def self.decoded_token(token)
    JWT.decode(token, SECRET, true, algorithm: 'HS256')
  rescue JWT::ExpiredSignature, JWT::DecodeError
    false
  end
end
