require 'rails_helper'

include Rack::Test::Methods

def app
  Rails.application
end

feature 'users' do
  scenario '' do
    get '/'
    assert last_response.ok?
  end

  scenario 'are created when route receives a name racktest' do
    post '/users/new', params: "name: 'Joe'"
    expect(last_response.body).to contain "Joe"
  end
end

# scenario 'are created when route receives a name capybara' do
#   page.driver.post('/users/new', params: { name: 'Joe' })
#   expect(page.driver.status_code).to eq 200
# end
# http://www.suffix.be/blog/capybara-post-requests