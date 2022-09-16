require 'rails_helper'

RSpec.describe "/posts/comments", type: :request do
  let(:post) { FactoryBot.create(:post) }

  describe 'POST /create' do
    it 'creates a new comment' do
      user = FactoryBot.create(:user)
      sign_in user
      expect {
        post post_comments_url(post_id: post.id), params: { comment: { body: "Cool!" } }
      }.to change(Comment, :count).by(1)
    end

    it "redirects to the post" do
      post post_comments_url(post_id: post.id), params: { comment: { body: "Cool!" } }
      expect(response).to redirect_to(post_url(post))
    end
  end

  describe 'PATCH /update' do
    it 'updates the requested comment' do
      comment = FactoryBot.create(:comment, commentable: post)
      patch post_comment_url(post, comment), params: { comment: { body: 'Nice!'} }
      comment.reload
      expect(response).to redirect_to(post_url(post))
    end
  end

  describe 'DELETE /destroy' do
    it 'deletes the requested comment' do
      comment = FactoryBot.create(:comment, commentable: post)
      expect {
        delete post_comment_url(post, comment)
      }.to change(Comment, :count).by(-1)
    end
  end
end
