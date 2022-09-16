require 'rails_helper'

RSpec.describe '/posts', type: :request do

  let(:user) { FactoryBot.create(:user) }

  let(:valid_attributes) {
    { body: 'This is a test.',
      user: user }
  }

  let(:invalid_attributes) {
    { body: nil,
      user: user }
  }

  before(:each) { sign_in user }

  describe "GET /index" do
    it "returns a success response" do
      get posts_url
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    context "with valid params" do
      it "creates a new Post" do
        expect {
          post posts_url, params: {post: valid_attributes}
        }.to change(Post, :count).by(1)
      end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post posts_url, params: {post: invalid_attributes}
        expect(response).to have_http_status(:success)
      end
    end
  end


  describe "GET /show" do
    it "returns a success response" do
      post = Post.create! valid_attributes
      get post_url(post), params: {id: post.to_param}
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns a success response" do
      post = Post.create! valid_attributes
      get edit_post_url(post), params: {id: post.to_param}
      expect(response).to have_http_status(:success)
    end
  end


  describe "PATCH /update" do
    context "with valid params" do
      let(:new_attributes) {
        { body: 'Test edit.' }
      }

      it "updates the requested post" do
        post = Post.create! valid_attributes
        patch post_url(post), params: {id: post.to_param, post: new_attributes}
        post.reload
        expect(post.body).to eq('Test edit.')
      end
    end

  describe "DELETE /destroy" do
    it "destroys the requested post" do
      post = Post.create! valid_attributes
      expect {
        delete post_url(post), params: {id: post.to_param}
      }.to change(Post, :count).by(-1)
    end
   end
  end
 end
end
