class UsersController < ApplicationController
  before_action :authorized, only: [:auto_login]

  def index
    result =
      if current_user
        { user: User.all.map(&:public_fields), message: 'Success', status: :success }
      else
        { message: 'Please sign_up or log in', status: :error }
      end

    render json: result
  end

  def show
    result =
      if current_user
        { user: current_user.public_fields, message: 'Success', status: :success }
      else
        { message: 'Please sign_up or log in', status: :error }
      end

    render json: result
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.valid?
      token = encode_token({ user_id: @user.id })
      render json: { user: @user, token: token }
    else
      render json: { error: 'Invalid email or password' }
    end
  end

  def login
    @user = User.find_by(name: params[:name])

    if @user&.authenticate(params[:password])
      token = encode_token({ user_id: @user.id })
      render json: { user: @user, token: token }
    else
      render json: { error: 'Invalid email or password' }
    end
  end

  def auto_login
    render json: @user
  end

  def destroy
    @user.destroy
  end

  private

  def user_params
    params.require(:user).permit(:name, :surname, :password, :password_confirmation, :email)
  end
end