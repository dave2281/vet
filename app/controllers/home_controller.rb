class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @categories = Category.all
    @users = User.all
  end

  def category
    @questions = Question.all
  end
end
