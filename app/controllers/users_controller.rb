class UsersController < ApplicationController
  before_action :authorize_access_request!
  before_action :set_user, only: [:show, :update]
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

  def unicorn
    @unicorn = current_user.unicorn

    render json: @unicorn
  end

  def update
    @user.update(demand: true)
  end

  def current
    @user = current_user
    if @user.admin
      outpout = { admin: 'true', id: current_user.id }.to_json
      render json: outpout
    else
      outpout = { admin: 'false', id: current_user.id }.to_json
      render json: outpout
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:demand, :admin, :email, :password_digest)
  end
end
