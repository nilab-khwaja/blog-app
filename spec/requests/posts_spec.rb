require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /posts' do
    user = User.create(name: 'Still Rollin', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                       bio: 'Singer from India', post_counter: 3)

    it 'return a successful response' do
      get user_posts_path(user)
      expect(response).to have_http_status(200)
    end

    it 'renders the index template ' do
      get user_posts_path(user)
      expect(response).to render_template(:index)
    end

    it 'includes correct placeholder to the response body' do
      get user_posts_path(user)
      expect(response.body).to include('show all posts by a spesific user')
    end
  end

  describe 'GET /posts/:id' do
    user = User.create(name: 'Still Rollin', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                       bio: 'Singer from India', post_counter: 3)
    post = Post.create(title: 'Hello World', author: user)
    it 'return a successful response' do
      get user_post_path(user, post)
      expect(response).to have_http_status(200)
    end

    it 'renders the index template ' do
      get user_post_path(user, post)
      expect(response).to render_template(:show)
    end

    it 'includes correct placeholder to the response body' do
      get user_post_path(user, post)
      expect(response.body).to include('Specific post for a specific user')
    end
  end
end
