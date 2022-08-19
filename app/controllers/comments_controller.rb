class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      flash[:notice]= 'Your comment was successfully posted!'
      redirect_to @commentable
    else
      flash[:alert]= "Error"
      redirect_back fallback_location: root_path
    end
  end

  def update
    if @comment.update
      flash[:notice]= "Changes saved!"
      redirect_to @comment.commentable
    else
      flash[:alert]= "Error updating"
      render :edit
    end
  end

  def show
  end

  def edit
  end 

  def destroy
    if @comment.destroy
     flash[:notice]= "Comment deleted"
    else
     flash[:alert]= "Error"
    end
    redirect_back fallback_location: root_path
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end
end
