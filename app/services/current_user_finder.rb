class CurrentUserFinder
  include JsonWebToken

  def initialize(session)
    @session = session[:token]
  end

  def call
    user
  end

  private

  attr_reader :session

  def user
    return unless session.present?

    user_id = JsonWebToken.decoded_token(session)[0]['user_id']
    User.find_by(id: user_id)
  end
end
