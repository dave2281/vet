require 'rails_helper'

RSpec.describe CommentsController, type: :controller do 
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
      title: 'Category title',
      description: 'Category description',
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

  let!(:comment) do
    Comment.create(
      text: 'Comment text',
      question: question,
      user: user
    )
  end

  before do
    sign_in user # Аутентификация пользователя перед каждым тестом
  end
  
  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { category_id: category.id, question_id: question.id, id: comment.id }
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new, params: { category_id: category.id, question_id: question.id } 
      expect(response).to be_successful
    end
  end

  describe 'PATCH #update' do
    let(:new_attributes) do
      { text: 'Updated comment text' }
    end

    it 'updates the requested comment' do
      patch :update, params: { category_id: category.id, question_id: question.id, id: comment.id, comment: new_attributes }
      comment.reload
      expect(comment.text).to eq('Updated comment text')
      expect(response).to redirect_to(category_question_comment_path(question.category_id, question.id, comment.id))
    end
  end

  describe 'POST #create' do
    let(:valid_attributes) do
      { text: 'Test text' }
    end
  
    let(:invalid_attributes) do
      { text: nil }
    end
  
    context 'with valid params' do
      it 'creates a new comment' do
        expect do
          post :create, params: { category_id: category.id, question_id: question.id, comment: valid_attributes }
        end.to change(Comment, :count).by(1)
      end
  
      it 'returns a successful response in JSON format' do
        post :create, params: { category_id: category.id, question_id: question.id, comment: valid_attributes }, format: :json
        expect(response).to have_http_status(:created)
      end
    end
  
    context 'with invalid params' do
      it 'does not create a new comment' do
        expect do
          post :create, params: { category_id: category.id, question_id: question.id, comment: invalid_attributes }, as: :json
        end.to change(Comment, :count).by(0) 
      end
  
      it 'returns an unprocessable entity response' do
        post :create, params: { category_id: category.id, question_id: question.id, comment: invalid_attributes }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end 
    end
  end
  
  describe 'DELETE #destroy' do
    it 'destroys the requested comment' do
      comment_to_delete = Comment.create!(text: 'Test comment', question: question, user: user)
      expect {
        delete :destroy, params: { category_id: category.id, question_id: question.id, id: comment_to_delete.id }
      }.to change(Comment, :count).by(-1)
      expect(response).to redirect_to(category_question_path(category, question))
    end
  end  
end