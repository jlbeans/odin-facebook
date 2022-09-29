require 'rails_helper'

feature 'requires authentication' do
  scenario 'Redirects to login page' do
    visit new_post_path
    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end
end

feature 'creates a new post form' do
  given(:user) { FactoryBot.create(:user) }

  background(:each) { sign_in user }

  scenario 'Includes input field for new post' do
    visit new_post_url
    expect(page).to have_field('post[body]', placeholder: "What's on your mind?")
  end

  feature 'creates a post' do
    background(:each) do
      visit new_post_url
      fill_in 'post[body]', with: 'First post.'
      click_on 'Post'
      expect(page).to have_content 'First post.'
    end
  end
end

feature 'edits a post' do
  given(:user) { FactoryBot.create(:user) }
  given(:post) { FactoryBot.create(:post, user: user) }

  background(:each) { sign_in user }

  scenario 'has an edit page' do
    visit edit_post_url(post)
    expect(page).to have_button 'Post'
  end

  scenario 'updates post and redirects to show page' do
    visit edit_post_url(post)
    fill_in 'post[body]', with: 'Edited post.'
    click_on 'Post'
    expect(page).to have_content 'Edited post.'
  end
end

feature 'deletes a post' do
  given(:user) { FactoryBot.create(:user) }
  given(:post) { FactoryBot.create(:post, user: user) }

  background(:each) { sign_in user }

  scenario 'post is not visible after deletion' do
    visit post_url(post)
    find(".trash").click
    expect(page).not_to have_content post.body
  end
end
