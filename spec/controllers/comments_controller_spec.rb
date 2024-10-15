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
    sign_in user
  end
  
  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { category_id: category.id, question_id: question.id, id: comment.id }
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new
      expect(response).to be_successful
    end
  end

  describe 'PATCH #update' do
    let(:new_attributes) do
      { text: 'Comment text', question: question, user: user }
    end

    it 'returns a success response' do
      patch :update, params: { id: comment.id, category_id: category.id, question_id: question.id, comment: new_attributes}
      comment.reload

      expect(comment.text).to eq('Comment text')
      expect(response).to redirect_to(comment)
    end
  end
end
