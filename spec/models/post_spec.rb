require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validations' do
    it 'should contain a body' do
      post = FactoryBot.build(:post, body: '')
      expect(post.valid?).to be false
    end
  end

  describe 'active record associations' do
    subject(:post) { FactoryBot.build(:post) }

    it { should belong_to(:user) }
    it { should have_many(:likes) }
    it { should have_many(:comments) }
  end
 end
