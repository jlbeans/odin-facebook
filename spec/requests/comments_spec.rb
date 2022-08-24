require 'rails_helper'

RSpec.describe "Comments", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:commentable) { FactoryBot.create(:post) }
  let(:comment) { FactoryBot.create(:comment, commentable: commentable, user: user) }
  before(:each) { sign_in user }


  describe 'POST #create' do
    it 'renders a successful response' do
      commentable.comments.create(user: user, body: "Cool!")
      get polymorphic_path(commentable, :comments)
      expect(response). to be_successful
    end
  end

  describe "GET #show" do
    it "renders a successful response" do
      comment
      get comment_path(comment)
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
  it "renders a successful response" do
    get new_comment_path(commentable: commentable)
    expect(response).to be_successful
  end
end

describe "GET #edit" do
  it "render a successful response" do
    comment
    get edit_comment_url(comment)
    expect(response).to be_successful
  end
end

  describe 'PATCH #update' do
    it 'updates the requested comment' do
      comment
      patch comment_path(comment), params: { comment: { body: 'Nice!'} }
      comment.reload
      expect(response).to redirect_to(polymorphic_path(commentable))
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the requested comment' do
      comment
      expect {
        delete :destroy, params: { id: comment.id }
      }.to change(Comment, :count).by(-1)
    end
  end
end
