require 'rails_helper'

include Rack::Test::Methods

def app
  Rails.application
end

feature 'users' do
  scenario 'making sure rack test works and that there is a user route' do
    get '/users'
    assert last_response.ok?
  end

  scenario 'we can access a user' do
    @user = User.create(name: 'Bob')
    get '/users/17'
    expect(JSON.parse(last_response.body)['name']).to eq 'Bob'
    # Test fails, but this works: curl -X GET http://localhost:3000/users/2
  end

  scenario 'are created when route receives a name racktest' do
    post '/users', name: 'JoeBob'
    expect(JSON.parse(last_response.body)['name']).to eq 'JoeBob'
    # This test will pass when I remove the require from the params in the controller
    # This works: curl -X POST -d "name=Steve" http://localhost:3000/users
  end
end
