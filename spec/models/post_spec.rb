require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { User.create(name: 'Example User') }

  it 'is valid with valid attributes' do
    post = described_class.new(
      title: 'Valid Title',
      author: user
    )
    expect(post).to be_valid
  end

  it 'is not valid without a title' do
    post = described_class.new(author: user)
    expect(post).not_to be_valid
    expect(post.errors[:title]).to include("can't be blank")
  end

  it 'is not valid with a title longer than 250 characters' do
    post = described_class.new(
      title: 'A' * 251,
      author: user
    )
    expect(post).not_to be_valid
    expect(post.errors[:title]).to include('is too long (maximum is 250 characters)')
  end

  it 'sets counters to zero after initialization' do
    post = described_class.new
    expect(post.comments_counter).to eq(0)
    expect(post.likes_counter).to eq(0)
  end

  it 'updates post counter for author after save' do
    post = described_class.create(
      title: 'Valid Title',
      author: user
    )
    expect(user.reload.post_counter).to eq(1)
  end
end
