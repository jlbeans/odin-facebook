require 'rails_helper'

RSpec.describe "/users", type: :request do
  let(:user) { FactoryBot.create(:user) }
  before(:each) { sign_in user }

  describe 'GET /index' do
    it 'returns http success' do
      get '/users/index'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get user_url(user)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #edit' do
    it 'returns http success' do
      get edit_user_url(user)
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH #update" do
    it 'updates the user info' do
      patch user_url(user), params: { user: { profession: 'Job'} }
      user.reload
      expect(response).to have_http_status(:success)
    end
  end
end
