class UsersController < ApplicationController
  def show
    @user = User.find_by(id: params[:id])
    if @user.nil?
      flash[:danger] = t("users.not_find_user")
      redirect_to root_url
    end
  end
end
