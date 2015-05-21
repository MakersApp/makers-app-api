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
end
