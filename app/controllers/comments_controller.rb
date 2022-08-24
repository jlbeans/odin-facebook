class CommentsController < ApplicationController
  # You can exclude the 'only' below since the list of actions includes
  # all the actions in the controller
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
    # Seems like you would need to pass in the comment_params for the update
    # to actually update anything.
    # @comment.update(comment_params)
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
    # https://api.rubyonrails.org/classes/ActionController/Redirecting.html#method-i-redirect_to
    redirect_back fallback_location: root_path, status: 303
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end
end
