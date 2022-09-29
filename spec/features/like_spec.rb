require 'rails_helper'

feature 'likes' do
  given(:user) { FactoryBot.create(:user) }
  given(:post) { FactoryBot.create(:post) }
  given(:like) { FactoryBot.create(:like, likable: post) }

  background(:each) { sign_in user }

  scenario 'thumbs up icon turns blue when post has been liked by user' do
    visit post_url(post)
    expect(page).not_to have_css('.liked')
    find('.like').click
    expect(page).to have_css('.liked')
    find('.unlike').click
    expect(page).not_to have_css('.liked')
  end
end
