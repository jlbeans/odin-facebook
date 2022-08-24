class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:notice]= "Changes saved, profile updated!"
      redirect_to @user
    else
      flash[:error]= "Error updating"
      render :edit
    end
  end

 private

  def user_params
    params.require(:user).permit(:location, :profession, :avatar)
  end
end
