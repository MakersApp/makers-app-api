require 'rails_helper'

describe TeamMember do
  it 'has a name, slack profile name and image' do
    team_member = described_class.new(name: 'Nikesh', slack_name: 'nikesh', image_path: 'https://avatars2.githubusercontent.com/u/7963753')
    expect(team_member.name).to eq 'Nikesh'
    expect(team_member.slack_name).to eq 'nikesh'
    expect(team_member.image_path).to eq 'https://avatars2.githubusercontent.com/u/7963753'
  end
end
