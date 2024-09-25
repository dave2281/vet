class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @pagy, @categories = pagy(Category.all, limit: 3)
    @users = User.all
  end

  def category
    @questions = Question.order(created_at: :desc)
  end
end
