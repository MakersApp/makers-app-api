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
    # curl -X POST -d "user_id=2" http://localhost:3000/users/2/visits
  end

  scenario 'sends a message to Slack' do
    post 'users/1/visits/', user_id: 1
    expect(JSON.parse(last_response.body).to_s).to include ":sanjsanj:"
    # curl -X POST --data-urlencode 'payload={"channel": "#visitors", "username": "webhookbot", "text": "Nikesh says, hey @james, you sure are looking great today.", "icon_emoji": ":nikesh:",  "link_names": 1}' https://hooks.slack.com/services/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
  end
end
