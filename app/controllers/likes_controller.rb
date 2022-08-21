class LikesController < ApplicationController


  def create
    # Could also do this as follows:
    # @like = @likable.likes.new(user: current_user)
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
    # Should probably scope this to only the current_user's likes
    like = Like.find(params[:id])
    # Probably best to use safe navigation here, just in case the page is stale
    # and the user clicks tries to unlike something they've already unliked in
    # a separate tag.
    # if like&.destroy
    if like.destroy
     flash[:notice]= "Unliked!"
    else
     flash[:alert]= "Error"
    end
    # https://api.rubyonrails.org/classes/ActionController/Redirecting.html#method-i-redirect_to
    redirect_back fallback_location: root_path, status: 303
  end
end
