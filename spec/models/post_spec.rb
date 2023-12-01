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

  it 'Should show the 5 recent comments of a post' do
    user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                       bio: 'Teacher from Mexico.')
    post = Post.create(author: user, title: 'Hello', text: 'This is my first post')
    comment1 = Comment.create(post:, user:, text: 'Hi There!', created_at: 6.hours.ago)
    comment2 = Comment.create(post:, user:, text: 'Hello There!', created_at: 5.hours.ago)
    comment3 = Comment.create(post:, user:, text: 'This is Chandan!', created_at: 4.hours.ago)
    comment4 = Comment.create(post:, user:, text: 'Coding is challanging!',
                              created_at: 3.hours.ago)
    comment5 = Comment.create(post:, user:, text: 'But practice!', created_at: 2.hours.ago)
    comment6 = Comment.create(post:, user:, text: 'Bye!', created_at: 1.hours.ago)
    expect(post.five_recent_comments_post).to eq([comment6, comment5, comment4, comment3, comment2])
    expect(post.five_recent_comments_post).to_not include(comment1)
  end
end
