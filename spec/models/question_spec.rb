require 'rails_helper'

RSpec.describe Question, type: :model do
  describe 'validations' do
    context 'general question validations' do
      let(:user) do
        User.new(
          name: 'Vitalik',
          surname: 'Winston',
          email: 'vitalik@example.com',
          password: 'password123',
          role: 'member'
        )
      end

      let(:category) do
        Category.new(
          title: 'Category',
          description: 'Some description about category',
          user:
        )
      end

      let(:question) do
        Question.new(
          title: 'How?',
          text: 'how what why',
          user:,
          category:
        )
      end

      it 'is valid with valid attributes' do
        expect(question).to be_valid
      end

      it { should validate_presence_of(:title) }
      it { should validate_presence_of(:text) }
    end
  end

  describe 'associations' do
    context 'with category' do
      it { should belong_to(:category) }
    end

    context 'with comment' do
      it { should have_many(:comments).dependent(:destroy) }
    end

    context 'with user' do
      it { should belong_to(:user) }
    end
  end
end
