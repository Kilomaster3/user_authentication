class ApplicationController < ActionController::Base
  include JsonWebToken

  def current_user
    @current_user ||= CurrentUserFinder.new(session).call
  end

  def logged_in?
    !current_user.nil?
  end

  def redirect_unauthenticated
  redirect_to(login_path, status: 401) unless logged_in?
  end
end