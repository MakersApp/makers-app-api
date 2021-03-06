require 'rails_helper'

feature 'feedback' do

  scenario 'is sent via API call' do
    stub_request(:any, Rails.application.secrets.google_form_url)

    post '/feedback', phoneID: 'asdf', enjoyed: true, questions: 'No thanks', email: 'test@t.com'
    expect(WebMock).to have_requested(:post, Rails.application.secrets.google_form_url)
  end

end