require 'rails_helper'

feature 'creates a comment' do
  given(:user) { FactoryBot.create(:user) }
  given(:post) { FactoryBot.create(:post) }

  background(:each) { sign_in user }

  scenario 'creates a form for commenting on a post' do
    visit post_url(post)
    expect(page).to have_field('comment[body]', placeholder: "Add a comment")
  end

  scenario 'comments on a post' do
    visit post_url(post)
    fill_in 'comment[body]', with: 'Thanks.'
    find('.is-primary').click
    expect(page).to have_content('Thanks.')
  end
end

feature 'edits a comment' do
  given(:user) { FactoryBot.create(:user) }
  given(:post) { FactoryBot.create(:post) }
  given(:comment) { FactoryBot.create(:comment, commentable: post) }

  background(:each) { sign_in user }

  scenario 'has an edit page' do
    visit edit_comment_url(comment)
    expect(page).to have_button('Update Comment')
  end

  scenario 'updates comments and redirects to commentable' do
    visit edit_comment_url(comment)
    fill_in 'comment[body]', with: 'Edited comment.'
    find('.is-primary').click
    expect(page).to have_content('Edited comment.')
  end
end

feature 'deleting a comment' do
  given(:user) { FactoryBot.create(:user) }
  given(:post) { FactoryBot.create(:post) }
  given(:comment) { FactoryBot.create(:comment, user: user, commentable: post) }

  background(:each) { sign_in user }

  scenario 'deletes comment' do
    visit comment_url(comment)
    find(".trash").click
    expect(page).not_to have_content comment.body
  end
end
