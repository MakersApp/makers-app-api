class TeamMembersController < ApplicationController
  def index
    @team_members = TeamMember.all
    render json: @team_members
  end
end
