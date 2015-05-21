class VisitsController < ApplicationController
  def index
  end

  def create
    @visit = Visit.new(visit_params)
    @visit.save
    render json: @visit
  end

  def visit_params
    params.permit(:user_id)
  end
end
