require 'rails_helper'

RSpec.describe Like, type: :model do
  subject(:like) { FactoryBot.build(:like) }

  describe 'active record associations' do
    it { should belong_to(:user) }
    it { should belong_to(:likable) }
  end
end
