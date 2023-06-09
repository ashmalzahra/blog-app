require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Tom', posts_counter: 0) }

  before { subject.save }

  it 'name should be present, expected false' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'name should be present, expected true' do
    expect(subject).to be_valid
  end

  it 'posts_counter has to be greater or equal to 0, expected false' do
    subject.posts_counter = nil
    expect(subject).to_not be_valid
  end

  it 'posts_counter has to be greater or equal to 0, expected true' do
    expect(subject).to be_valid
  end

  it 'posts_counter has to be greater or equal to 0, expected true' do
    subject.posts_counter = 1
    expect(subject).to be_valid
  end

  let(:user) { User.new(name: 'Tom', posts_counter: 0) }

  it 'last_three_post methods should return the last 3 posts related to the user' do
    Post.create(author: user, title: 'This is a post', likes_counter: 0, comments_counter: 0)
    Post.create(author: user, title: 'This is second post', likes_counter: 0, comments_counter: 0)
    Post.create(author: user, title: 'This is third post', likes_counter: 0, comments_counter: 0)
    Post.create(author: user, title: 'This is fourth post', likes_counter: 0, comments_counter: 0)
    expect(user.last_three_posts.length).to equal(3)
  end
end
