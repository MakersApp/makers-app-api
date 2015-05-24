require 'rails_helper'

feature 'visits' do

  scenario 'exist in the API' do
    get "/visits"
    assert last_response.ok?
  end

  scenario 'are created when route receives a team member' do
    post "/visits", team_member: 'Nikesh', phone_id: 'asdf'
    expect(JSON.parse(last_response.body)['team_member']).to eq 'Nikesh'
  end

  let!(:user) { User.create(name: 'James', phone_id: 'asdf') }
  let!(:visit) { Visit.create(team_member: 'Nikesh', phone_id: 'asdf') }

  context 'when user checks in' do

    scenario 'visit status changes to checked in' do
      stub_request(:any, Rails.application.secrets.slack_webhook)

      expect(visit.checkedin).to eq false
      patch "/checkin", phone_id: 'asdf'
      checked_in_visit = Visit.find_by(phone_id: visit.phone_id)
      expect(checked_in_visit.checkedin).to eq true
    end

    scenario 'the API sends a message to Slack' do
      stub_request(:any, Rails.application.secrets.slack_webhook)

      patch "/checkin", phone_id: 'asdf'
      expect(WebMock).to have_requested(:post, Rails.application.secrets.slack_webhook)
    end

    xscenario 'the message has the correct user and team member name' do
      patch "/checkin", phone_id: 'asdf'
      expect(JSON.parse(last_response.body).to_s).to include 'Nikesh'
    end
  end
end

# curls for visual testing:

# CREATE A VISIT
# curl -X POST -d "team_member=Nikesh&phone_id=asdf" http://localhost:3000/visits

# CHECK IN A USER
# curl -X PATCH -d "phone_id=qwerty" http://localhost:3000/checkin

# SEND YOUR OWN SLACK MESSAGE
# curl -X POST --data-urlencode 'payload={"channel": "#visitors", "username": "webhookbot", "text": "Hey @james, you sure are looking great today.", "icon_emoji": ":sanjsanj:",  "link_names": 1}' https://hooks.slack.com/services/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
