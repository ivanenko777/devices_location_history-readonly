class SessionsController < ApplicationController

  def new
    @user = User.new
    render :login
  end

  def create
    @user = User.find_by(email: params[:email])

    if @user && !@user.is_active
      flash.now[:alert] = 'User is not active'
      render :login
    elsif @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to root_path, notice: 'Logged in!'
    else
      flash.now[:alert] = 'Email or password is invalid'
      render :login
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'Logged out!'
  end
end
