class AddTeamMemberToVisits < ActiveRecord::Migration
  def change
    add_column :visits, :team_member, :string
  end
end
