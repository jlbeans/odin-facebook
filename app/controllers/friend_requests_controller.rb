class FriendRequestsController < ApplicationController
  before_action :set_friend_request, except: [:create, :index]

  def index
    @incoming_requests = current_user.received_friend_requests
  end

  def create
    @friend_request = FriendRequest.create(sender_id: current_user.id, receiver_id: params[:receiver_id])
    if @friend_request.save
      flash[:notice] = "Friend request sent!"
    else
      flash[:alert] = "Error creating request"
    end
    redirect_back(fallback_location: user_path(current_user))
  end

  def cancel
    if @friend_request.sender == current_user
     @friend_request.destroy
      flash[:notice]= "Friend request canceled!"
    else
      flash[:alert] = "Error canceling request"
    end
    redirect_back(fallback_location: root_path, status: 303)
  end

  def accept
    if @friend_request.receiver == current_user
      FriendShip.create!(user: current_user, friend: @friend_request.sender)
      @friend_request.destroy
      flash[:notice]= "Friend request accepted!"
    else
      flash[:alert]= "Error accepting request"
    end
    redirect_back(fallback_location: user_path(current_user))
  end

  def decline
    if @friend_request.receiver == current_user
      @friend_request.destroy
      flash[:notice]= "Friend request declined!"
    else
      flash[:alert]= "Error declining request"
    end
    redirect_back(fallback_location: root_path, status: 303)
  end


private

  def set_friend_request
    @friend_request = FriendRequest.find(params[:id])
  end
end
