class ApplicationController < ActionController::API
  include JsonWebToken

  def auth_header
    request.headers[:email]
  end

  def logged_in_user
    return unless decoded_token

    user_id = decoded_token[0]['user_id']
    @user = User.find_by(id: user_id)
  end

  def logged_in?
    !!logged_in_user
  end

  def authorized
    render json: { message: 'Please login' }, status: :unauthorized unless logged_in?
  end

  def current_user
    session[:token] && User.find_by(@token, email: session[:email])
  end
end