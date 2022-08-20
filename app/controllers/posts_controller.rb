class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts= Post.all
    @post = Post.new
 end

 def create
   @post = Post.new(post_params)
   @post.user = current_user

   if @post.save
     flash[:notice]= 'You successfully posted!'
     redirect_to @post
   else
     flash[:alert]= "Error saving"
     redirect_back fallback_location: root_path
   end
 end

 def show
 end

 def edit
 end

 def destroy
   if @post.destroy
    flash[:notice]= "Post deleted"
   else
    flash[:notice]= "Error"
   end
   redirect_back  fallback_location: root_path
 end

 def update
   if @post.update(post_params)
     flash[:notice]= "Changes saved!"
     redirect_to @post
   else
     flash[:alert]= "Error updating"
     render :edit
   end
 end


 private

 def post_params
   params.require(:post).permit(:body)
 end

 def set_post
   @post = Post.find(params[:id])
 end
end
