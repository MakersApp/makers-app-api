class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def create
    @user = User.new(user_params)
    @user.save
    render json: @user
  end

  def show
    @user = User.find(params[:id])
    render json: @user.name
  end

  def user_params
    params.require(:user).permit(:name)
  end
end
