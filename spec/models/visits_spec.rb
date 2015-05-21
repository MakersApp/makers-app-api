require 'rails_helper'

describe Visit do
  it 'has a time created field' do
    visit = described_class.create(user_id: 1)
    expect(visit.created_at).not_to be nil
  end
end
