require 'rails_helper'

feature 'team members' do
  scenario 'exist in the database' do
    get '/team_members'
    assert last_response.ok?
  end

  scenario 'are available to be called by the app' do
    get '/team_members'
    expect(JSON.parse(last_response.body).count).to eq 9
  end
end

# curls to visually test

# ACCESS ALL TEAM MEMBERS
# curl -X GET http://localhost:3000/team_members