class FriendRequestsController < ApplicationController
  def index
    @incoming_requests = current_user.received_friend_requests
  end

  def create
    @friend_request = current_user.sent_friend_requests.create(friend_request_params)
    if @friend_request.save
      flash[:notice] = "Friend request sent!"
    else
      flash[:alert] = "Error creating request"
    end
    redirect_to user_path(friend_request_params[:receiver_id])
  end

  def destroy
    friend_request = current_user.friend_requests.find_by(id: params[:id])
    if friend_request&.destroy
      flash[:notice]= "Friend request removed!"
    else
      flash[:alert] = "Error deleting request"
    end
    redirect_back(fallback_location: root_path, status: 303)
  end


  private

  def friend_request_params
    params.require(:friend_request).permit(:sender_id, :receiver_id)
  end
end
