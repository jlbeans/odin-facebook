require 'rails_helper'

RSpec.describe "/users", type: :request do
  let(:user) { FactoryBot.create(:user) }
  before(:each) { sign_in user }

  describe 'GET /index' do
    it 'returns http success' do
      get users_url
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

  describe "PATCH /update" do
    context "with valid attributes" do
      let(:new_attributes) {
        { profession: 'Job',
           location: 'LA' }
      }

      it "updates the user's info" do
        patch user_url(user), params: { id: user.to_param, user: new_attributes }
        user.reload
        expect(user.profession).to eq('Job')
      end
    end
  end
end
