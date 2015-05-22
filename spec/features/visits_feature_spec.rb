require 'rails_helper'

include Rack::Test::Methods

def app
  Rails.application
end

feature 'visits' do
  scenario 'exist in the API' do
    get 'users/1/visits'
    assert last_response.ok?
  end

  scenario 'are created when route receives a user id' do
    post 'users/1/visits/', user_id: 1
    expect(JSON.parse(last_response.body)['user_id']).to eq 1
    # curl -X POST -d "user_id=3" http://localhost:3000/users/3/visits
  end

  scenario 'change status to checked in when a user arrives' do
    user = User.create(name: 'James')
    visit = Visit.create(user_id: user.id)
    expect(visit.checkedin).to eq false
    patch "users/#{user.id}/visits/#{visit.id}", checkedin: true
    visit = Visit.find(visit.id)
    expect(visit.checkedin).to eq true
    # curl -X PATCH -d "checkedin=true" http://localhost:3000/users/2/visits/1
  end

  xscenario 'sends a message to Slack' do
    post 'users/1/visits/', user_id: 1
    expect(JSON.parse(last_response.body).to_s).to include ":sanjsanj:"
    # curl -X POST --data-urlencode 'payload={"channel": "#visitors", "username": "webhookbot", "text": "Hey @james, you sure are looking great today.", "icon_emoji": ":sanjsanj:",  "link_names": 1}' https://hooks.slack.com/services/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
  end
end
