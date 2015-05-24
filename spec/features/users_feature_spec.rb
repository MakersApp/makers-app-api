require 'rails_helper'

feature 'users' do
  scenario 'exist in the API' do
    get '/users'
    assert last_response.ok?
  end

  scenario 'are created when route receives a name and phone id' do
    post '/users', name: 'JoeBob', phone_id: 'asdf'
    expect(JSON.parse(last_response.body)['name']).to eq 'JoeBob'
    expect(JSON.parse(last_response.body)['phone_id']).to eq 'asdf'
    # curl -X POST -d "name=Steve" http://localhost:3000/users
  end

  scenario 'can be accessed via get request' do
    new_user = User.create(name: 'Bob')
    get "/users/#{new_user.id}"
    expect(JSON.parse(last_response.body)['name']).to eq 'Bob'
    # curl -X GET http://localhost:3000/users/2
  end
end
