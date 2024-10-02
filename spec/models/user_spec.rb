require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    context 'general user validations' do
      it 'is valid with valid attributes' do
        user = User.new(name: 'Test', surname: 'Testenko', email: 'test@example.com', password: 'password123')
        expect(user).to be_valid
      end

      it 'is not valid without attributes' do
        user = User.new
        expect(user).not_to be_valid
      end

      it { should_not validate_presence_of(:name) }
      it { should validate_presence_of(:email) }
    end

    context 'validations for doctor role' do
      let(:doctor_user) do
        User.new(
          name: 'Vitalik',
          surname: 'Winston',
          email: 'vitalik@example.com',
          password: 'password123',
          role: 'doctor'
        )
      end

      it 'is valid with valid attributes' do
        doctor_user.description = 'University of Cow'
        doctor_user.experience = '20 years of work in Tokyo'
        expect(doctor_user).to be_valid
      end

      it 'requires a description to be valid' do
        expect(doctor_user).to validate_presence_of(:description)
      end

      it 'is invalid without a description' do
        doctor_user.description = nil
        expect(doctor_user).to_not be_valid
        expect(doctor_user.errors[:description]).to include("can't be blank")
      end

      it 'is invalid without experience' do
        doctor_user.experience = nil
        expect(doctor_user).to_not be_valid
        expect(doctor_user.errors[:experience]).to include("can't be blank")
      end
    end
  end

  describe 'associations' do
    context 'with category' do
      it { should have_many(:categories).dependent(:destroy) }
    end

    context 'with question' do
      it { should have_many(:questions).dependent(:destroy) }
    end

    context 'with comment' do
      it { should have_many(:comments).dependent(:destroy) }
    end
  end
end
