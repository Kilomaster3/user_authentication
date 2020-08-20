class UsersController < ApplicationController

  def index
    result =
      if current_user
        { user: current_user, message: 'Success', status: :success }
      else
        { message: 'Please Signup or login', status: :error }
      end

    render json: result
  end

  def show
    result =
      if current_user
        { user: current_user.public_fields, message: 'Success', status: :success }
      else
        { message: 'Please Signup or login', status: :error }
      end

    render json: result
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      token = encode_token({ user_id: @user.id })
      session[:token] = token
      render json: { user: @user, token: token }
    else
      render 'new'
    end
  end

  def destroy
    @user.destroy
  end

  private

  def user_params
    params.require(:user).permit(:name, :surname, :password, :password_confirmation, :email)
  end
end