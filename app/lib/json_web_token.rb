module JsonWebToken
  class << self
    SECRET = Rails.application.credentials.secret_key_base

    def encode_token(payload)
      JWT.encode(payload, SECRET)
    end

    def decoded_token(token)
      JWT.decode(token, SECRET)
    rescue JWT::DecodeError
      nil
    end
  end
end