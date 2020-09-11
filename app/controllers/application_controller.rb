class ApplicationController < ActionController::Base
  include JsonWebToken

  def logged_in?
    !current_user.nil?
  end

  def authorized
    render json: { message: 'Please login' }, status: :unauthorized unless logged_in?
  end

  def current_user
    return unless session[:token].present?

    user_id = JsonWebToken.decoded_token(session[:token])[0]['user_id']
    User.find_by(id: user_id)
  end
end
