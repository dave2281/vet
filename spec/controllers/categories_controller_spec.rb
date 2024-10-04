require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  let!(:user) do
    User.create(
      name: 'Vitalik',
      surname: 'Vitalikovic',
      email: 'vitalik@example.com',
      password: 'password123'
    )
  end

  let!(:category) do
    Category.create(
      title: 'hello',
      description: 'category description',
      user:
    )
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get :index, format: :json
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { id: category.id }
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new, params: { title: 'Category title', description: 'Category description', user_id: user.id }
    end
  end

  describe 'PATCH #update' do
    let(:new_attributes) do
      { title: 'Updated title', description: 'Updated description' }
    end

    it 'returns a success response' do
      patch :update, params: { id: category.id, category: new_attributes }
      category.reload

      expect(category.title).to eq('Updated title')
      expect(category.description).to eq('Updated description')
      expect(response).to redirect_to(category)
    end
  end

  describe 'POST #create' do
    let(:valid_attributes) do
      { title: 'New category', description: 'Category description', user_id: user.id }
    end

    let(:invalid_attributes) do
      { description: 'Category description' }
    end

    context 'with valid parameters' do
      it 'creates a new Category' do
        expect do
          post :create, params: { category: valid_attributes }
        end.to change(Category, :count).by(1)
      end

      it 'redirects to the new category' do
        post :create, params: { category: valid_attributes }
        expect(response).to redirect_to(Category.last)
        expect(flash[:notice]).to eq('Category was successfully created.')
      end

      it 'returns a successful response in JSON format' do
        post :create, params: { category: valid_attributes, format: :json }
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Category' do
        expect do
          post :create, params: { category: invalid_attributes }
        end.to change(Category, :count).by(0)
      end

      it 'does not redirect to the new category' do
        post :create, params: { category: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'does not return a successful response in JSON format' do
        post :create, params: { category: invalid_attributes, format: :json }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
