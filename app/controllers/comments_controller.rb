class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  def index
    @comments = @commentable.comments
  end

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @comment, flash[:notice]= 'Your comment was successfully posted!'
    else
      redirect_to :back, flash[:alert]= "Error"
    end
  end

  def update
    if @comment.update
      redirect_to comment, flash[:notice]= "Changes saved!"
    else
      redirect_to :back, flash[:alert]= "Error updating"
    end
  end

  def show

  end

  def destroy
    @comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end
end
