require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject(:comment) { FactoryBot.build(:comment) }

  describe 'validations' do
    it { should validate_presence_of(:body) }
  end


  describe 'active record associations' do
    it { should belong_to(:user) }
    it { should belong_to(:commentable) }
    it { should have_many(:likes) }
    it { should have_many(:comments) }
  end
end
