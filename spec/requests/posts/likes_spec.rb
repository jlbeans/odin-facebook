require 'rails_helper'

RSpec.describe "/posts/likes", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:likable) { FactoryBot.create(:post) }

  before(:each) { sign_in user }

  describe 'POST /create' do
    it 'creates a new like' do
      expect {
        post post_likes_url(likable)
      }.to change(Like, :count).by(1)
    end
  end

  describe 'DELETE /destroy' do
    it 'deletes the requested like' do
      like= FactoryBot.create(:like, user: user)
      expect {
        delete post_like_url(like.likable, like)
      }.to change(Like, :count).by(-1)
    end
  end
end
