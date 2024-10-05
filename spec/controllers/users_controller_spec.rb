require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let!(:admin_user) do
    create(:user)
  end

  let!(:user) do 
    create(:user, role: 'member')
  end

  before do
    sign_in user
  end 

  describe 'GET #index' do
    context 'as admin' do
      before(:each) do
        sign_in admin_user
      end

      it 'returns a successful response' do
        get :index, format: :json
        expect(response).to have_http_status(:ok)
      end
    end

    context 'as member' do
      before(:each) do 
        sign_in user
      end

      it 'returns a failed response' do
        expect {
          get :index
        }.to raise_error(Pundit::NotAuthorizedError)
      end
    end
  end

  describe 'GET #show' do
    it 'returns a successful response' do
      get :show, params: { id: user.id}
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #new' do
    it 'returns a successful response' do
      get :new
    expect(response).to be_successful
    end
  end

  describe 'PATCH #update' do
    let(:new_attributes) {
      { name: 'New name', surname: 'New surname' }
    }

    it 'returns a success response' do
      Rails.logger.info("USER NAME:: #{new_attributes}")
      patch :update, params: { id: user.id, user: new_attributes }
      user.reload
      
      expect(user.name).to eq("New name")
      expect(user.surname).to eq('New surname')
      expect(response).to redirect_to(user)
    end
  end

  describe 'POST #create' do
    let(:valid_attributes) do 
      {name: Faker::Name.name, surname: Faker::Name.name, email: Faker::Internet.email, password: 'password123', role: 'member'}
    end 

    let(:invalid_attributes) do 
      {email: Faker::Internet.email, password: 'password123', role: 'member'}
    end

    context 'with valid params' do
      it 'creates a new user' do
        expect do
          post :create, params: { user: valid_attributes}
        end.to change(User, :count).by(1)
      end
    end
  end
end
