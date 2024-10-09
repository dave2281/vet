require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:text) }
  end

  describe 'associations' do
    it { should belong_to(:question) }
    it { should belong_to(:user) }
  end
end
