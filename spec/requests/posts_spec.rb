require 'rails_helper'

RSpec.describe PostsController, type: :controller do

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

  describe "GET #index" do
    it "returns a success response" do
      Post.create! valid_attributes
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Post" do
        expect {
          post :create, params: {post: valid_attributes}
        }.to change(Post, :count).by(1)
      end

      it "redirects to the created post" do
        post :create, params: {post: valid_attributes}
        expect(response).to be_successful
      end
    end


    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: {post: invalid_attributes}
        expect(response).to be_successful
      end
    end
  end


  describe "GET #show" do
    it "returns a success response" do
      post = Post.create! valid_attributes
      get :show, params: {id: post.to_param}
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      post = Post.create! valid_attributes
      get :edit, params: {id: post.to_param}
      expect(response).to be_successful
    end
  end


  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { body: 'Test edit.' }
      }

      it "updates the requested post" do
        post = Post.create! valid_attributes
        put :update, params: {id: post.to_param, post: new_attributes}
        post.reload
        expect(post.body).to eq('Test edit.')
      end
    end

  describe "DELETE #destroy" do
    it "destroys the requested post" do
      post = Post.create! valid_attributes
      expect {
        delete :destroy, params: {id: post.to_param}
      }.to change(Post, :count).by(-1)
    end

    it "redirects to the posts list" do
      post = Post.create! valid_attributes
      delete :destroy, params: {id: post.to_param}
      expect(response).to redirect_to(posts_url)
    end
   end
  end
 end
