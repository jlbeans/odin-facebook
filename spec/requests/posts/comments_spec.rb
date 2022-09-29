require 'rails_helper'

RSpec.describe "/posts/comments", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:commentable) { FactoryBot.create(:post) }

  before(:each) { sign_in user }

  describe 'POST /create' do
    it 'creates a new comment' do
      expect {
        post post_comments_url(commentable), params: { comment: { body: 'Testing.'} }
      }.to change(Comment, :count).by(1)
    end
  end

  describe 'GET /show' do
    it 'shows the requested comment' do
      comment= FactoryBot.create(:comment, user: user)
      get post_comment_url(comment.commentable, comment), params: {id: comment.to_param}
      expect(response).to have_http_status(:success)
    end
  end


  describe 'PATCH /update' do
      context "with valid params" do
        let(:new_attributes) {
          { body: 'Test edit.' }
        }

        it "updates the requested comment" do
          comment= FactoryBot.create(:comment, user: user)
          patch post_comment_url(comment.commentable, comment), params: { id: comment.to_param, comment: new_attributes }
          comment.reload
          expect(comment.body).to eq('Test edit.')
        end
      end
    end

  describe 'DELETE /destroy' do
    it 'deletes the requested comment' do
      comment= FactoryBot.create(:comment, user: user)
      expect {
        delete post_comment_url(comment.commentable, comment), params: { id: comment.to_param }
      }.to change(Comment, :count).by(-1)
    end
  end
end
