class CommentsController < ApplicationController
  before_action :set_comment, except: [:create]

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      flash[:notice]= 'You created a comment!'
    else
      flash[:alert]= "Error saving comment"
    end
    redirect_to @commentable
  end

  def update
    if @comment&.update(comment_params)
      flash[:notice]= "Changes saved, comment has been updated!"
      redirect_to @comment.commentable
    else
      flash[:alert]= "Error updating"
      render :edit
    end
  end

  def show
    @comment
  end

  def edit
  end

  def destroy
    if @comment&.destroy
     flash[:notice]= "Comment deleted!"
    else
     flash[:alert]= "Error deleting comment"
    end
    # https://api.rubyonrails.org/classes/ActionController/Redirecting.html#method-i-redirect_to
    redirect_to @comment.commentable, status: 303
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_comment
    @comment= Comment.find(params[:id])
  end
end
