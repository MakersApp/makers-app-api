class VisitsController < ApplicationController
  def index
  end

  def create
    @user = User.find(params[:user_id])
    @user.visit.create(visit_params)
  end

  def visit_params
    params.permit(:user_id)
  end
end
