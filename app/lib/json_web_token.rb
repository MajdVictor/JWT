#
# This class is used to encode and decode JWT tokens.
class JsonWebToken
  SECRET_KEY = Rails.application.secrets.secret_key_base.to_s

  def self.encode(payload:, expiry: 1.hour.from_now)
    payload[:exp] = expiry.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def self.decode(token:)
    JWT.decode(token, SECRET_KEY)
  end
end