require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with valid attributes' do
    user = described_class.new(name: 'Example User')
    expect(user).to be_valid
  end

  it 'is not valid without a name' do
    user = described_class.new
    expect(user).not_to be_valid
    expect(user.errors[:name]).to include("can't be blank")
  end

  it 'is not valid with a negative post counter' do
    user = described_class.new(name: 'Example User', post_counter: -1)
    expect(user).not_to be_valid
    expect(user.errors[:post_counter]).to include('must be greater than or equal to 0')
  end

  it 'sets post counter to zero after initialization' do
    user = described_class.new
    expect(user.post_counter).to eq(0)
  end
end
