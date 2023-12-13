require 'rails_helper'

RSpec.feature 'User Index Page', type: :feature do
  before do
    @user1 = User.create(name: 'User1', photo: 'user1.jpg')
    @user2 = User.create(name: 'User2', photo: 'user2.jpg')
    @user1.posts.create(title: 'Post 1', text: 'Content 1')
    @user2.posts.create(title: 'Post 2', text: 'Content 2')
  end

  scenario 'User sees username, profile picture, and post count' do
    visit users_path

    # Use Capybara to check if the page displays usernames, profile pictures, and post counts for each user.
    expect(page).to have_content(@user1.name)
    expect(page).to have_css("img[src*='user1.jpg']") # Assuming you use an image tag with src attribute.
    expect(page).to have_content(@user1.posts.count)

    expect(page).to have_content(@user2.name)
    expect(page).to have_css("img[src*='user2.jpg']")
    expect(page).to have_content(@user2.posts.count)
  end

  scenario 'User clicks on a user and is redirected to the show page' do
    visit users_path

    # Use Capybara to simulate clicking on a user and check if redirected to the user's show page.
    click_on @user1.name

    expect(current_path).to eq(user_path(@user1))
  end

  scenario 'User clicks on another user and is redirected to that user\'s show page' do
    visit users_path

    # Use Capybara to simulate clicking on another user and check if redirected to the user's show page.
    click_on @user2.name

    expect(current_path).to eq(user_path(@user2))
  end
end
