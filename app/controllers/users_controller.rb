class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice]= "Profile updated"
      redirect_to @user
    else
      flash[:error]= "An error occured"
      render :edit
    end
  end




private

  def user_params
    params.require(:user).permit(:location, :profession, :avatar)
  end
end