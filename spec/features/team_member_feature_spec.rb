require 'rails_helper'

feature 'team members' do
  scenario 'exist in the database' do
    get '/team_members'
    assert last_response.ok?
  end
end
