class FriendRequestsController < ApplicationController

  def index
    @outgoing = current_user.sent_friend_requests
    @incoming = current_user.received_friend_requests
  end

  def create
    @friend_request = current_user.sent_friend_requests.build(friend_request_params)
    if @friend_request.save
      flash[:notice] = "Friend request sent!"
      redirect_back(fallback_location: users_path)
    else
      flash[:alert] = "Something went wrong"
      redirect_to user_path(friend_request_params[:receiver_id])
    end
  end

  def destroy
    friend_request = FriendRequest.find(params[:id])
    if friend_request.destroy
      flash[:notice]= "Friend request removed!"
    else
      flash[:alert] = "Something went wrong"
    end
    redirect_back(fallback_location: users_path)
  end


  private

  def friend_request_params
    params.require(:friend_request).permit(:sender_id, :receiver_id)
  end
end
