module SpecTestHelper
  include JsonWebToken
  def login_user(user)
    token = JsonWebToken.encode_token({ user_id: user.id })
    session[user.id] = token
  end
end

RSpec.configure do |config|
  config.include SpecTestHelper, type: :controller
end