class CommentsController < ApplicationController
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
    if comment&.update
      flash[:notice]= "Changes saved, comment has been updated!"
      redirect_to comment.commentable
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
    if comment&.destroy
     flash[:notice]= "Comment deleted!"
    else
     flash[:alert]= "Error deleting comment"
    end
    # https://api.rubyonrails.org/classes/ActionController/Redirecting.html#method-i-redirect_to
    redirect_back fallback_location: root_path, status: 303
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def comment
    @comment ||= Comment.find(params[:id])
  end
end
