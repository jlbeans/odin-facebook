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
    friend_request = FriendRequest.find(params[:id])
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
