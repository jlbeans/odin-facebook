class FriendShipsController < ApplicationController

  def index
    @friends = current_user.friends
  end

  def destroy
    friendship = FriendShip.find(params[:id])
    if friendship&.destroy
      flash[:notice] = "Friend successfully removed"
    else
      flash[:alert] = "Oops, something went wrong"
    end
    redirect_back(fallback_location: root_path, status: 303)
  end
end
