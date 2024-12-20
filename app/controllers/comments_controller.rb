class CommentsController < ApplicationController
  before_action :set_question
  before_action :authenticate_user!
  before_action :set_comment, only: %i[edit update destroy show]

  def new
    @comment = Comment.new
    @category = Category.find(Question.find(params[:question_id]).category_id)
  end

  def edit; end

  def create
    @comment = @question.comments.new(comment_params)
    @comment.user = current_user
  
    respond_to do |format|
      if @comment.save
        format.html do
          redirect_to category_question_path(@question.category_id, @question.id),
                      notice: 'Comment was successfully created.'
        end
        format.json { render json: @comment, status: :created }
      else
        format.html do
          redirect_to category_question_path(@question.category_id, @question.id), alert: 'Error creating comment.'
        end
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end  

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to category_question_comment_path(@question.category_id, @question.id, @comment.id), notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment.destroy
  
    respond_to do |format|
      format.html do
        redirect_to category_question_path(@question.category_id, @question.id), status: :see_other,
                                                                            notice: 'Comment was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end
  
  private

  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:text, :user_id, :question_id)
  end
end
