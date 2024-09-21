class CommentsController < ApplicationController
  before_action :set_question
  before_action :authenticate_user!
  before_action :set_comment, only: %i[ show edit update destroy ]

  def show
  end

  def new
    @comment = Comment.new
  end

  def edit
  end

  def create
    @comment = @question.comments.new(comment_params)
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.html { redirect_to question_url(@question), notice: "Comment was successfully created." }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { redirect_to question_url(@question), alert: "Error creating comment." }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: "Comment was successfully updated." }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment.destroy!

    respond_to do |format|
      format.html { redirect_to authenticated_root_path, status: :see_other, notice: "Comment was successfully destroyed." }
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
