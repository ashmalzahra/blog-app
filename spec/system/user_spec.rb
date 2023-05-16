require 'rails_helper'

RSpec.describe User, type: :system do
  subject { User.new(name: 'Tom', posts_counter: 2, photo: 'https://picsum.photos/300/300', bio: 'Teacher') }
  let(:lilly) { User.new(name: 'Lilly', posts_counter: 0, photo: 'https://picsum.photos/300/300', bio: 'Student') }
  let(:first_post) { Post.new(author: subject, title: 'Hello', likes_counter: 0, comments_counter: 0) }
  let(:second_post) { Post.new(author: subject, title: 'Hi', likes_counter: 0, comments_counter: 0) }
  let(:third_post) { Post.new(author: subject, title: 'Hey', likes_counter: 0, comments_counter: 0) }

  before { subject.save }
  before { lilly.save }
  before { first_post.save }
  before { second_post.save }
  before { third_post.save }

  describe 'index page' do
    it 'renders user Lilly name' do
      visit '/'
      expect(page).to have_content('Lilly')
    end
    it 'renders user Tom name' do
      visit '/'
      expect(page).to have_content('Tom')
    end
    it 'image of user Lilly' do
      visit '/'
      expect(page.find("#user-#{lilly.id}")['src']).to have_content 'https://picsum.photos/300/300'
    end
    it 'image of user Tom' do
      visit '/'
      expect(page.find("#user-#{subject.id}")['src']).to have_content 'https://picsum.photos/300/300'
    end
    it 'posts counter of Lilly' do
      visit '/'
      expect(page.find("#counter-#{lilly.id}")).to have_content lilly.posts_counter.to_s
    end
    it 'posts counter of Tom' do
      visit '/'
      expect(page.find("#counter-#{subject.id}")).to have_content subject.posts_counter.to_s
    end
    it 'redirects from user index to user show Tom' do
      visit '/' # Visit the user index page
      find('span', text: subject.name).click
      expect(page).to have_current_path("/users/#{subject.id}", ignore_query: true)
    end
    it 'redirects from user index to user show Lilly' do
      visit '/' # Visit the user index page
      find('span', text: lilly.name).click
      expect(page).to have_current_path("/users/#{lilly.id}", ignore_query: true)
    end
  end

  describe 'show page' do
    it "displays the user's picture." do
      visit "/users/#{subject.id}"
      expect(page.find('img')['src']).to have_content subject.photo
    end
    it 'rnders the name of the user' do
      visit "/users/#{subject.id}"
      expect(page).to have_content(subject.name)
    end

    it 'renders the number of posts' do
      visit "/users/#{subject.id}"
      expect(page.find('.post-num')).to have_content subject.posts_counter.to_s
    end

    it 'renders the bio' do
      visit "/users/#{subject.id}"
      expect(page.find('.bio')).to have_content subject.bio.to_s
    end

    it 'renders the first three posts' do
      visit "/users/#{subject.id}"
      expect(page).to have_selector('.post-data', count: 3)
    end

    it 'renders see all posts button' do
      visit "/users/#{subject.id}"
      expect(page).to have_content 'See all posts'
    end

    it 'redirects to show page of that post when the user clicks on the post' do
      visit "/users/#{subject.id}"
      find("#show-post-#{first_post.id}").click
      expect(page).to have_current_path("/users/#{subject.id}/posts/#{first_post.id}", ignore_query: true)
    end

    it 'redirects to post index page when the user clicks on see all posts' do
      visit "/users/#{subject.id}"
      find('#all-posts').click
      expect(page).to have_current_path("/users/#{subject.id}/posts", ignore_query: true)
    end
  end
end