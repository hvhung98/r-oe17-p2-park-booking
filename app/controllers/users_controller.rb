class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find_by(id: params[:id])
    return if @user
    flash[:danger] = t("users.not_find_user")
    redirect_to root_url
  end
end
