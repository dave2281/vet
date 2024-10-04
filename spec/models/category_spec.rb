require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
  end

  describe 'associations' do
    it { should have_many(:questions).dependent(:destroy) }
    it { should belong_to(:user) }
  end
end
