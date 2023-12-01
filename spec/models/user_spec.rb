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

  context 'User Method #three_recent_posts' do
    it 'return the three_recent_posts for a user' do
      first_user = User.create(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                               bio: 'Teacher from Poland.')

      post1 = Post.create(author: first_user, title: 'First title', text: 'First Post', created_at: 4.hours.ago)
      post2 = Post.create(author: first_user, title: 'Second title', text: 'Second Post', created_at: 3.hours.ago)
      post3 = Post.create(author: first_user, title: 'Third title', text: 'Third Post', created_at: 2.hours.ago)
      post4 = Post.create(author: first_user, title: 'Fourth title', text: 'Fourth Post', created_at: 1.hours.ago)

      recent_posts = first_user.three_recent_posts

      expect(recent_posts).to eq([post4, post3, post2])
      expect(recent_posts).to_not include(post1)
    end
  end
end
