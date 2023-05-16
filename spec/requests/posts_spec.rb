require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /index' do
    it 'renders index template' do
      user = User.create(name: 'Ashmal', posts_counter: 0)
      get "/users/#{user.id}/posts"
      expect(response).to render_template(:index)
    end

    it 'returns http success' do
      user = User.create(name: 'Ashmal', posts_counter: 0)
      get "/users/#{user.id}/posts"
      expect(response).to be_successful
    end

    it 'Test if users/:user_id/posts is rendering the text' do
      user = User.create(name: 'Ashmal', posts_counter: 0)
      get "/users/#{user.id}/posts"
      expect(response.body).to include('Ashmal')
    end
  end

  describe 'GET /show' do
  let(:user) { User.create(name: 'Tom', posts_counter: 0) }
  let(:post) { Post.create(author: user, title: 'Hello', comments_counter: 0, likes_counter: 0) }

  it 'renders show template' do
    get "/users/#{user.id}/posts/#{post.id}"
    expect(response).to render_template(:show)
  end

  it 'returns http success' do
    get "/users/#{user.id}/posts/#{post.id}"
    expect(response).to be_successful
  end

  it 'Test if /users/:user_id/posts/:id is rendering the text' do
    get "/users/#{user.id}/posts/#{post.id}"
    expect(response.body).to include('Comments', 'Add a comment')
  end
end
end
