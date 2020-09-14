class UsersController < ApplicationController
  before_action :unauthenticated_user, only: %i[index show]

  def index
    @users = User.all
  end

  def show
    @user = current_user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'Welcome into your Page'
      session[:token] = JsonWebToken.encode_token({ user_id: @user.id })
      redirect_to @user
    else
      render 'new'
    end
  end

  private

  def unauthenticated_user
    redirect_back(fallback_location: '/login', notice: 'Please Login') unless logged_in?
  end

  def user_params
    params.require(:user).permit(:name, :surname, :password, :password_confirmation, :email)
  end
end
