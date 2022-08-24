require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  before(:each) { sign_in user }

  describe 'GET #index' do
    it 'renders all users page' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    it 'renders user show page' do
      get :show, params: { id: user.id }
      expect(response).to render_template(:show)
    end
  end

  describe 'GET #edit' do
    it 'renders user edit profile page' do
      get :edit, params: { id: user.id }
      expect(response).to render_template(:edit)
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { location: 'place', profession: 'job' }
      }

      it "updates user's info" do
        put :update, params: { id: user.id, user: new_attributes }
        user.reload
        expect(user.profession).to eq('job')
      end
    end
  end
end
