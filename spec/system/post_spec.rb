require 'rails_helper'

RSpec.describe Post, type: :system do
   let(:user) { User.new(name: 'Tom', posts_counter: 0, photo: 'https://picsum.photos/300/300', bio: 'Teacher') }
  subject do
    Post.create(author: user, title: 'Hello', text: 'This is my first post', likes_counter: 0,
                comments_counter: 0)
  end
  let(:lilly) { User.new(name: 'Lilly', posts_counter: 0, photo: 'https://picsum.photos/300/300', bio: 'Student') }
  let(:comment) { Comment.new(text: 'Nice', post: subject, author: user) }

  before { subject.save }
  before { lilly.save }
  before { user.save }
  before { comment.save }

   describe 'index page' do
    it 'show the user profile picture' do
      visit "/users/#{user.id}/posts"
      sleep(4)
      expect(page.find("img")['src']).to have_content user.photo
    end
    it 'shows the User name' do
      visit "/users/#{user.id}/posts"
      sleep(2)
      expect(page).to have_content(user.name)
    end
    it 'shows the posts counter from user profile' do
      visit "/users/#{user.id}/posts"
      sleep(2)
      expect(page.find(".post-num")).to have_content user.posts_counter.to_s
    end
    it 'shows the post title on posts#index' do
      visit "/users/#{user.id}/posts"
      sleep(2)
      expect(page).to have_content subject.title
    end
    it 'shows the post text on posts#index' do
      visit "/users/#{user.id}/posts"
      sleep(2)
      expect(page).to have_content subject.text
    end
    it 'shows the first comment of a post on posts#index' do
      visit "/users/#{user.id}/posts"
      sleep(2)
      expect(page).to have_content comment.text
    end
    it 'shows the number of comments of a post on posts#index' do
      visit "/users/#{user.id}/posts"
      sleep(2)
      expect(page.find("#comments-#{subject.id}")).to have_content subject.comments_counter.to_s
    end
    it 'show the number of likes of a post on posts#index' do
      visit "/users/#{user.id}/posts"
      sleep(2)
      expect(page.find("#likes-#{subject.id}")).to have_content subject.likes_counter.to_s
    end
    it 'shows the see all post button' do
      visit "/users/#{user.id}/posts"
      sleep(2)
      expect(page).to have_content('Pagination')
    end
    it 'redirects from post#index to post#show' do
      visit "/users/#{user.id}/posts" # Visit the user index page
      sleep(2)
      find("#test-#{subject.id}", text: subject.title).click # Click on the user's link
      expect(page).to have_current_path("/users/#{user.id}/posts/#{subject.id}", ignore_query: true) # Verify the redirection to user show page
    end
  end
   describe 'show page' do
    it 'shows the post title on posts#show' do
      visit "/users/#{user.id}/posts/#{subject.id}"
      expect(page).to have_content subject.title
    end
    it 'shows the User name on the post' do
      visit "/users/#{user.id}/posts/#{subject.id}"
      expect(page).to have_content(user.name)
    end
    it 'shows the number of comments on a post of posts#index' do
      visit "/users/#{user.id}/posts/#{subject.id}"
      expect(page.find('.comment-num')).to have_content subject.comments_counter.to_s
    end
    it 'shows the number of likes on a post of posts#index' do
      visit "/users/#{user.id}/posts/#{subject.id}"
      expect(page.find('.like-num')).to have_content subject.likes_counter.to_s
    end
    it 'shows the text on the post of post#show' do
      visit "/users/#{user.id}/posts/#{subject.id}"
      expect(page.find('.post-data')).to have_content subject.text
    end
    it 'shows the user name of the comment of posts#index' do
      visit "/users/#{user.id}/posts/#{subject.id}"
      expect(page.find("#comment-#{comment.id}")).to have_content user.name
    end
    it 'shows the text of the comment of posts#index' do
      visit "/users/#{user.id}/posts/#{subject.id}"
      expect(page.find("#comment-#{comment.id}")).to have_content comment.text
    end
  end
end
