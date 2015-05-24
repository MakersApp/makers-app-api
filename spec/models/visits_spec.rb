require 'rails_helper'

describe Visit do

  let(:user) { double :user, id: 1 }

  it 'is created' do
    visit = described_class.create(team_member: 'Nikesh', phone_id: 'asdf')
    expect(visit.created_at).not_to be nil
  end

  it 'has a team member associated' do
  end
end
