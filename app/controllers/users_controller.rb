class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :comfirm_user, only: [:edit, :update, :destroy]
  def show
    @items = @user.items
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(params[:id])
      else
        render :edit
      end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:nickname, :email)
  end

  def comfirm_user
    unless @user.id == current_user.id
      redirect_to root_path
    end
  end
end
