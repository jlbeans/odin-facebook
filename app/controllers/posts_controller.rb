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
     redirect_to @post, flash[:notice]= 'You successfully posted!'
   else
     redirect_to :back, flash[:alert]= "Error saving"
   end
 end

 def show
 end

 def edit
 end

 def destroy
   if @post.destroy
     redirect_to root_path, flash[:notice]= "Post deleted"
   else
     redirect_to :back, flash[:notice]= "Error"
   end
 end

 def update
   if @post.update(post_params)
     redirect_to @post, flash[:notice]= "Changes saved!"
   else
     redirect_to :edit, flash[:alert]= "Error updating"
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
