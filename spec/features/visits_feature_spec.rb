require 'rails_helper'

include Rack::Test::Methods

def app
  Rails.application
end

feature 'visits' do

  let(:user) { User.create(name: 'James') }

  scenario 'exist in the API' do
    get "users/#{user.id}/visits"
    assert last_response.ok?
  end

  scenario 'are created when route receives a user id' do
    post "users/#{user.id}/visits/", user_id: user.id
    expect(JSON.parse(last_response.body)['user_id']).to eq user.id
    # curl -X POST -d "user_id=3" http://localhost:3000/users/3/visits
    # curl -X POST -d "user_id=2" https://makersvisitorapi.herokuapp.com/users/1/visits
  end

  scenario 'change status to checked in when a user arrives' do
    visit = Visit.create(user_id: user.id)
    expect(visit.checkedin).to eq false
    patch "users/#{user.id}/visits/#{visit.id}", checkedin: true
    visit = Visit.find(visit.id)
    expect(visit.checkedin).to eq true
    # curl -X PATCH -d "checkedin=true" http://localhost:3000/users/2/visits/1
    # curl -X PATCH -d "checkedin=true" https://makersvisitorapi.herokuapp.com/users/1/visits/1
  end

  scenario 'sends a message to Slack with correct visitor name' do
    visit = Visit.create(user_id: user.id)
    patch "users/#{user.id}/visits/#{visit.id}", checkedin: true
    expect(JSON.parse(last_response.body).to_s).to include ":sanjsanj:"
    # curl -X POST --data-urlencode 'payload={"channel": "#visitors", "username": "webhookbot", "text": "Hey @james, you sure are looking great today.", "icon_emoji": ":sanjsanj:",  "link_names": 1}' https://hooks.slack.com/services/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
  end
end
