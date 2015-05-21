require 'rails_helper'

describe User do
  it 'has a name field' do
    user = described_class.new(name: 'Bob')
    expect(user.name).to eq 'Bob'
  end
end
