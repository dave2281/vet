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
      description: 'category description'
    )
  end

  describe 'GET #show' do
    get :show, params: { id: question.id }
  end
end
