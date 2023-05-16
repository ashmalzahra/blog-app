require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /index' do
    it 'renders index template' do
      get '/users'
      expect(response).to render_template(:index)
    end

    it 'returns http success' do
      get '/users'
      expect(response).to be_successful
    end

    it 'Test if /users is rendering the text' do
      get '/users'
      expect(response.body).to include('Welcome to my blog app!')
    end
  end

  describe 'GET /show' do
    it 'renders show template' do
      user = User.create(name: 'Ashmal', posts_counter: 0)
      get "/users/#{user.id}"
      expect(response).to render_template(:show)
    end

    it 'returns http success' do
      user = User.create(name: 'Ashmal', posts_counter: 0)
      get "/users/#{user.id}"
      expect(response).to be_successful
    end

    it 'Test if /users/:id is rendering the text' do
      user = User.create(name: 'Ashmal', posts_counter: 0)
      get "/users/#{user.id}"
      expect(response.body).to include('Ashmal')
    end
  end
end
