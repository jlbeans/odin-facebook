require 'rails_helper'
require 'feature_helper'

RSpec.configure do |c|
  c.include FeatureHelper
end

feature 'creates a comment' do
  given(:user) { FactoryBot.create(:user) }
  given(:post) { FactoryBot.create(:post) }
  given(:comment) { FactoryBot.create(:comment, commentable: post) }

  background(:each) { login user }

  scenario 'creates a comment on a post' do
    visit posts_url
    click_on 'Comments'
    fill_in 'comment_body', with: 'Nice shoes.'
    click_button 'Comment'
    expect(page).to have_content('Nice shoes.')
  end

  scenario 'creates a form for commenting on a comment' do
    visit post_comments_url(post)
    click_on 'Comments'
    expect(page).to have_field('comment_body', placeholder: "Add a comment")
  end

  scenario 'comments on a comment' do
    visit comment_comments_url(comment)
    click_on 'Comments'
    fill_in 'comment_body', with: 'Thanks.'
    click_button 'Comment'
    expect(page).to have_content('Thanks.')
  end
end
