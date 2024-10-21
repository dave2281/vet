require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
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
      user: user
    )
  end

  let!(:question) do
    Question.create(
      title: 'Question title',
      text: 'Question text',
      user: user,
      category: category
    )
  end

  before do 
    sign_in(user)
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { category_id: category.id, id: question.id }
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns success response' do
      get :new, params: { category_id: category.id }
      expect(response).to be_successful
    end
  end

  describe 'PATCH #update' do
    let(:new_attributes) do
      { title: 'Question title updated', text: 'Question text updated' }
    end

    it 'updates the requested question' do
      patch :update, params: { category_id: category.id, id: question.id, question: new_attributes }
      question.reload
      expect(question.title).to eq('Question title updated')
      expect(response).to redirect_to(category_question_path(question.category_id, question.id))
    end
  end

  describe 'POST #create' do
    let(:valid_attributes) do
      { title: 'Test title', text: 'Test text' }
    end

    let(:invalid_attributes) do
      { title: nil }
    end

    context 'with valid params' do
      it 'creates a new comment' do
        expect do
          post :create, params: { category_id: category.id, question: valid_attributes }
        end.to change(Question, :count).by(1)
      end

      it 'returns a successful response in JSON format' do
        post :create, params: { category_id: category.id, question: valid_attributes }, as: :json
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid params' do
      it 'does not create a new comment' do
        expect do 
          post :create, params: { category_id: category.id, question: invalid_attributes }
        end.to change(Question, :count).by(0)
      end

      it 'returns an unprocessable entity response' do
        post :create, params: { category_id: category.id, question: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:comment_to_delete) { Comment.create!(text: 'Test comment', question: question, user: user) }
  
    it 'destroys the requested comment' do
      expect {
        delete :destroy, params: { category_id: category.id, id: question.id }
      }.to change(Question, :count).by(-1)
      expect(response).to redirect_to(category_path(category.id))
    end
  end
  
end
