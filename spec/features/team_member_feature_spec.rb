require 'rails_helper'

feature 'team members' do
  scenario 'exist in the database' do
    get '/team_members'
    assert last_response.ok?
  end

  xscenario 'are available to be called by the app' do
    get '/team_members'
    expect(JSON.parse(last_response.body).count).to eq 8
  end
end