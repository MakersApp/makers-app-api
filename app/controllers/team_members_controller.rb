class TeamMembersController < ApplicationController
  def show
    @team_members = TeamMember.all
    render json: @team_members
  end
end
