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
    it 'returns a successful response' do
      @user = User.create(name: 'Bala', bio: 'Doctor from Turkey',
                          photo: 'https://img.freepik.com/kitten.jpg', post_counter: 2)
      get "/users/#{@user.id}"
      expect(response).to have_http_status(200)
    end

    it 'renders the show template' do
      @user = User.create(name: 'Bala', bio: 'Doctor from Turkey',
                          photo: 'https://img.freepik.com/kitten.jpg', post_counter: 2)
      get "/users/#{@user.id}"
      expect(response).to render_template(:show)
    end

    it 'includes correct placeholder in the response body' do
      @user = User.create(name: 'Bala', bio: 'Doctor from Turkey',
                          photo: 'https://img.freepik.com/kitten.jpg', post_counter: 2)
      get "/users/#{@user.id}"
      expect(response.body).to include('Show a specific user')
    end
  end
end
