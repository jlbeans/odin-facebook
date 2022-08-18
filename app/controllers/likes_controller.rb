class LikesController < ApplicationController

  def create
    @like = @likable.likes.new
    @like.user = current_user

    if @like.save
      flash[:notice]= 'Liked!'
      redirect_to @likable
    else
      flash[:alert]= "Error"
      redirect_back fallback_location: root_path
    end
  end

  def destroy
    like = Like.find(params[:id])
    if like.destroy
     flash[:notice]= "Unliked!"
    else
     flash[:alert]= "Error"
    end
    redirect_back fallback_location: root_path
  end
end
