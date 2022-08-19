class FriendShipsController < ApplicationController

  def index
    @friendships = current_user.friend_ships
  end

  def create
    friend_request = FriendRequest.find_by(receiver: current_user, sender: User.find(params[:sender_id]))
    friend = friend_request.sender
    if friend_request
      friend_request.accept
      flash[:notice] = "You are now friends with #{friend.name}"
      redirect_back(fallback_location: friend_requests_path)
    else
      redirect_to current_user
    end
  end

  def destroy
    user = User.find(params[:id])
    friend_ship = FriendShip.find_by(user: current_user, friend: user) || FriendShip.find_by(user: user, friend: current_user)
    friend_ship.destroy
    flash[:notice] = "Friend successfully removed"
    redirect_back(fallback_location: friend_requests_path)
  end
end
