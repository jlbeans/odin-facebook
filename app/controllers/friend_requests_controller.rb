class FriendRequestsController < ApplicationController

  def index
    @incoming_requests = current_user.received_friend_requests
  end

  def create
    @friend_request = current_user.sent_friend_requests.build(friend_request_params)
    if @friend_request.save
      flash[:notice] = "Friend request sent"
      redirect_back(fallback_location: users_path)
    else
      flash[:alert] = "Error"
      redirect_to user_path(friend_request_params[:receiver_id])
    end
  end

  def destroy
    # Though it probably doesn't matter all that much in this case, it's a
    # good practice to scope these sort of finds by the user. Otherwise a
    # smart (and devious) user could delete other people's friend requests.
    # current_user.friend_requests.find_by(id: params[:id])
    friend_request = FriendRequest.find(params[:id])
    # Add then since it's possible the friend request wouldn't be found, you'd
    # want to check for the presence before destroying
    # if friend_request&.destroy
    if friend_request.destroy
      flash[:notice]= "Friend request successfully removed"
    else
      flash[:alert] = "Error"
    end
    redirect_back(fallback_location: users_path)
  end


  private

  def friend_request_params
    params.require(:friend_request).permit(:sender_id, :receiver_id)
  end
end
