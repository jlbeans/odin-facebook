class PostsController < ApplicationController
  def index
    @posts= Post.all
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user

    if @post.save
     flash[:notice]= 'You created a new post!'
     redirect_to @post
    else
     flash[:alert]= "Error saving post"
     redirect_back fallback_location: root_path
    end
  end

  def show
  end

  def edit
  end

  def destroy
    if post.destroy
     flash[:notice]= "Post deleted!"
    else
     flash[:notice]= "Error removing post"
    end
    redirect_back fallback_location: root_path
  end

  def update
    if post.update(post_params)
      flash[:notice]= "Changes saved, post has been updated!"
      redirect_to post
    else
      flash[:alert]= "Error updating post"
      render :edit
    end
  end


 private

 def post_params
   params.require(:post).permit(:body)
 end

 def post
   @post ||= Post.find(params[:id])
 end
end
