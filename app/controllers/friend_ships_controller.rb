class FriendShipsController < ApplicationController
  def index
    @friendships = current_user.friend_ships
  end

  def create
    friend_request = FriendRequest.find_by(receiver: current_user, sender: User.find(params[:sender_id]))
    friend = friend_request.sender
    if friend_request&.accept
      flash[:notice] = "You are now friends with #{friend.name}!"
    else
      flash[:alert] = "Oops, something went wrong"
    end
    redirect_to friend
  end

  def destroy
    user = User.find(params[:id])
    friendship = FriendShip.find_by(user: current_user, friend: user) || FriendShip.find_by(user: user, friend: current_user)
    if friendship&.destroy
      flash[:notice] = "Friend successfully removed"
    else
      flash[:alert] = "Oops, something went wrong"
    end
    redirect_back(fallback_location: root_path)
  end
end
