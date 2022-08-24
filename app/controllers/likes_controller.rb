class LikesController < ApplicationController
  def create
    @like = @likable.likes.new(user: current_user)
    if @like.save
      flash[:notice]= 'Liked!'
    else
      flash[:alert]= "Oops, something went wrong"
    end
    redirect_to @likable
  end

  def destroy
    like = current_user.likes.find_by(id: params[:id])
    if like&.destroy
     flash[:notice]= "Unliked!"
    else
     flash[:alert]= "Oops, something went wrong"
    end
    # https://api.rubyonrails.org/classes/ActionController/Redirecting.html#method-i-redirect_to
    redirect_back fallback_location: root_path, status: 303
  end
end
