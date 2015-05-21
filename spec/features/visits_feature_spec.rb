require 'rails_helper'

include Rack::Test::Methods

def app
  Rails.application
end

feature 'visits' do
  scenario 'exist in the API' do
    get '/visits'
    assert last_response.ok?
  end
end
