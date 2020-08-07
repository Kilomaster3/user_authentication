class UsersController < ApplicationController
  before_action :unauthenticated_user, only: %i[index show]

  def index
    @users = User.all
    render json: @users
  end

  def show
    @user = current_user
    render json: @user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      session[:token] = JsonWebToken.encode_token({ user_id: @user.id })
      render json: { user: @user }
    else
      render 'new'
    end
  end

  
  private

  def unauthenticated_user
    redirect_back(fallback_location: '/sign_up') unless logged_in?
  end

  def user_params
    params.require(:user).permit(:name, :surname, :password, :password_confirmation, :email)
  end
end
