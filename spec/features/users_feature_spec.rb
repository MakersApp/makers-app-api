require 'rails_helper'

include Rack::Test::Methods

def app
  Rails.application
end

feature 'users' do
  scenario 'exist in the API' do
    get '/users'
    assert last_response.ok?
  end

  scenario 'can be accessed via get request' do
    new_user = User.create(name: 'Bob')
    get "/users/#{new_user.id}"
    expect(JSON.parse(last_response.body)['name']).to eq 'Bob'
    # curl -X GET http://localhost:3000/users/2
    # curl -X GET https://makersvisitorapi.herokuapp.com/users/1
  end

  scenario 'are created when route receives a name' do
    post '/users', name: 'JoeBob'
    expect(JSON.parse(last_response.body)['name']).to eq 'JoeBob'
    # curl -X POST -d "name=Steve" http://localhost:3000/users
    # curl -X POST -d "name=Sara" https://makersvisitorapi.herokuapp.com/users
  end
end
