class FriendShipsController < ApplicationController

  def index
    @friend_ships = current_user.friend_ships
  end

  def create
    friend_request = FriendRequest.find_by(receiver: current_user, sender: User.find(params[:sender_id]))
    friend = friend_request.sender
    if friend_request.any?
      friend_request.accept
      flash[:notice] = "You are now friends with #{friend.first_name}"
      redirect_back(fallback_location: friend_requests_path)
    else
      redirect_to current_user
    end
  end

  def destroy
    user = User.find(params[:id])
    friend_ships = FriendShip.where(user: current_user, friend: user).or(FriendShip.where(user: user, friend: current_user))
    if friend_ships.any?
      friend_ships.destroy_all
      redirect_back(fallback_location: friend_requests_path)
    else
      redirect_to user_path(user)
    end
  end
end
