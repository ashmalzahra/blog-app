require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { User.new(name: 'Tom', posts_counter: 0) }
  subject { Post.new(author: user, title: 'Hello', comments_counter: 0, likes_counter: 0) }

  before { subject.save }

  it 'title should be present, expected false' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'title should be present, expected true' do
    expect(subject).to be_valid
  end

  it 'title should be less than 250 characters, expected false' do
    subject.title = 'The Comprehensive Guide to Understanding the Complexities of Quantum Physics
     and the Intricacies of the Subatomic World: A Deep Dive into the Mysteries of the Universe,
    from the Smallest Particles to the Largest Structures, Exploring the Fundamentals of Quantum
    Mechanics, Relativity, Cosmology, and More.'
    expect(subject).to_not be_valid
  end

  it 'comments_counter has to be greater or equal to 0, expected false' do
    subject.comments_counter = nil
    expect(subject).to_not be_valid
  end

  it 'comments_counter has to be greater or equal to 0, expected true' do
    expect(subject).to be_valid
  end


  it 'comments_counter has to be greater or equal to 0, expected true' do
    subject.comments_counter = 1
    expect(subject).to be_valid
  end

  it 'likes_counter has to be greater or equal to 0, expected false' do
    subject.likes_counter = nil
    expect(subject).to_not be_valid
  end

  it 'likes_counter has to be greater or equal to 0, expected true' do
    expect(subject).to be_valid
  end


  it 'likes_counter has to be greater or equal to 0, expected true' do
    subject.likes_counter = 1
    expect(subject).to be_valid
  end

  let(:user_one) { User.create(name: 'Tom', posts_counter: 0) }
  let(:post_one) { Post.create(author: user_one, title: 'Hello', likes_counter: 0, comments_counter: 0) }

  it 'last_five comments methods should return the last 5 comments related to the post' do
    Comment.create(text: 'comment zero', post: post_one, author: user_one)
    Comment.create(text: 'comment one', post: post_one, author: user_one)
    Comment.create(text: 'comment two', post: post_one, author: user_one)
    Comment.create(text: 'comment three', post: post_one, author: user_one)
    Comment.create(text: 'comment four', post: post_one, author: user_one)
    Comment.create(text: 'comment five', post: post_one, author: user_one)
    expect(post_one.last_five_comments.length).to equal(5)
  end

  it 'update_post_counter methods should increment user posts_counter by one' do
    Post.create(author: user_one, title: 'Hello', likes_counter: 0, comments_counter: 0)
    expect(user_one.posts_counter).to equal(1)
  end
end
