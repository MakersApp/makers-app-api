require 'rails_helper'

describe Visit do

  let(:user) { double :user, id: 1 }

  it 'has a time created field' do
    visit = described_class.create(user_id: user.id)
    expect(visit.created_at).not_to be nil
  end
end
