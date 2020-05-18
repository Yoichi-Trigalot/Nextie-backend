class UsersController < ApplicationController
  before_action :set_user, only: :show
  def index
    @users = User.all

    render json: @users
  end

  def show
    render json: @user
  end

  def unicornDemands
    @demands = User.where(demand: true)

    render json: @demands
  end

  def current
    @user = current_user

    render json: @user
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:demand, :admin, :email, :password_digest)
  end
end
