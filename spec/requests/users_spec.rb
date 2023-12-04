require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /users' do
    it 'return a successful response' do
      get '/users'
      expect(response).to have_http_status(200)
    end

    it 'renders the index template ' do
      get '/users'
      expect(response).to render_template(:index)
    end

    it 'includes correct placeholder to the response body' do
      get '/users'
      expect(response.body).to include('List of all users')
    end
  end

  describe 'GET /users/:id' do
    it 'return a successful response' do
      get '/users/10'
      expect(response).to have_http_status(200)
    end

    it 'renders the index template ' do
      get '/users/10'
      expect(response).to render_template(:show)
    end

    it 'includes correct placeholder to the response body' do
      get '/users/10'
      expect(response.body).to include('Show a specific user')
    end
  end
end
