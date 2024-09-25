class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_question, only: %i[ show edit update destroy ]


  def index
    @questions = Question.all
  end

  def show
    @comment = @question.comments.new
    @comments = @question.comments
  end

  def new
    @category = Category.find(params[:category_id])
    @question = @category.questions.build
  end

  def edit
    @category = Category.find(params[:category_id])
    @question = @category.questions.find(params[:id])
  end

  def create
    @category = Category.find(params[:category_id])  # Найти категорию
    @question = @category.questions.build(question_params)  # Создание нового вопроса

    @question.user = current_user

    respond_to do |format|
      if @question.save
        format.html { redirect_to category_path(@category), notice: "Question was successfully created." }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: "Question was successfully updated." }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @question.destroy!

    respond_to do |format|
      format.html { redirect_to category_path(Category.find(params[:category_id])), status: :see_other, notice: "Question was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_question
      @question = Question.find(params[:id])
      @comments = @question.comments
      @category = Category.find(params[:category_id])
      @user = User.find(@question.user_id)
      @users = User.all
    end

    def question_params
      params.require(:question).permit(:title, :text, :category_id)
    end
end
