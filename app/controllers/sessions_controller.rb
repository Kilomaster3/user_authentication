class SessionsController < ApplicationController

  def new; end

  def create
    @user = User.find_by(email: params[:session][:email])
    if @user&.authenticate(params[:session][:password])
      flash[:success] = 'Welcome into your Page'
      session[:token] = JsonWebToken.encode_token({ user_id: @user.id })
      redirect_to user_path(@user)
    else
      flash[:danger] = 'Invalid email or password combination'
      redirect_to login_path
    end
  end

  def destroy
    session[:token] = nil
    redirect_to login_path
  end
end
