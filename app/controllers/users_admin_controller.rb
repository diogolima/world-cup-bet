class UsersAdminController < ApplicationController
  before_action :set_user_config, only: [:show, :edit, :update]
  before_action {check_admin home_path}
  def index
    @users = User.all
  end

  def edit
  end

  def update
    if @user.update(user_params)
      format.html { redirect_to users_admin_index_url, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  private
  def set_user_config
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :admin)
  end
end
