require 'rails_helper'

# include Rack::Test::Methods

# def app
#   Rails.application
# end

feature 'visits' do

  let(:user) { User.create(name: 'James') }

  scenario 'exist in the API' do
    get "/visits"
    assert last_response.ok?
  end

  scenario 'are created when route receives a team member' do
    post "/visits", team_member: 'Nikesh', phone_id: 'asdf'
    expect(JSON.parse(last_response.body)['team_member']).to eq 'Nikesh'
    # curl -X POST -d "team_member=Nikesh&phone_id=asdf" http://localhost:3000/visits
  end

  xscenario 'change status to checked in when a user arrives' do
    visit = Visit.create(team_member: 'Nikesh', phone_id: 'asdf')
    expect(visit.checkedin).to eq false
    patch "/visits", checkedin: true, phone_id: 'asdf'
    visit = Visit.find(visit.id)
    expect(visit.checkedin).to eq true
    # curl -X PATCH -d "checkedin=true" http://localhost:3000/users/2/visits/1
    # curl -X PATCH -d "checkedin=true" https://makersvisitorapi.herokuapp.com/users/1/visits/1
  end

  xscenario 'sends a message to Slack with correct visitor name' do
    Visit.create(team_member: 'Nikesh', phone_id: 'asdf')
    patch "/visits", checkedin: true, phone_id: 'asdf'
    expect(JSON.parse(last_response.body).to_s).to include ":sanjsanj:"
    # curl -X POST --data-urlencode 'payload={"channel": "#visitors", "username": "webhookbot", "text": "Hey @james, you sure are looking great today.", "icon_emoji": ":sanjsanj:",  "link_names": 1}' https://hooks.slack.com/services/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
  end
end
