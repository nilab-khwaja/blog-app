require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /posts' do
    it 'return a successful response' do
      get '/users/7/posts'
      expect(response).to have_http_status(200)
    end

    it 'renders the index template ' do
      get '/users/7/posts'
      expect(response).to render_template(:index)
    end

    it 'includes correct placeholder to the response body' do
      get '/users/7/posts'
      expect(response.body).to include('show all posts by a spesific user')
    end
  end

  describe 'GET /posts/:id' do
    it 'return a successful response' do
      get '/users/7/posts/2'
      expect(response).to have_http_status(200)
    end

    it 'renders the index template ' do
      get '/users/7/posts/2'
      expect(response).to render_template(:show)
    end

    it 'includes correct placeholder to the response body' do
      get '/users/7/posts/2'
      expect(response.body).to include('Specific post for a specific user')
    end
  end
end
