class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  def index
    @users = User.all
  end

  # GET /users/1
  def show; end

  # GET /users/new
  def new
    @user = User.new
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to @user, notice: 'User was successfully created.'
    else
      flash[:alert] = 'This form has errors.'
      render :new
    end
  end

  # GET /users/1/edit
  def edit; end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      flash[:alert] = 'This form has errors.'
      render :edit
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    redirect_to users_url, notice: 'User was successfully deleted.'
  rescue ActiveRecord::StatementInvalid
    flash[:alert] = "User can't be deleted."
    redirect_to @user
  end

  private

  def set_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = 'User not found.'
    redirect_to action: :index
  end

  def user_params
    params.require(:user).permit(:full_name, :email, :is_active, :password, :password_confirmation)
  end
end
