require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:comment) { FactoryBot.create(:comment, user: user) }
  let(:commentable) { FactoryBot.create(:post) }
  before(:each) { sign_in user }


  describe 'POST #create' do
    it 'creates a new Comment' do
      expect {
        post :create, params: { body: "Cool!" }
      }.to change(Comment, :count).by(1)
      expect(Comment.last.commentable).to eq(commentable)
    end
  end


  describe 'PATCH #update' do
    it 'updates an existing Comment' do
      comment
      expect {
        put :update, params: { id: comment.id, comment: { body: 'Nice!' } }
      }.to change(Comment, :count).by(0)
      comment.reload
      expect(comment.body).to eq('Nice!')
    end
  end

  describe 'DELETE #destroy' do
    let(:comment) { FactoryBot.create(:comment) }

    it 'deletes the requested comment' do
      sign_in comment.user
      expect {
        delete :destroy, params: { id: comment.id }
      }.to change(Comment, :count).by(-1)
    end
  end
end
