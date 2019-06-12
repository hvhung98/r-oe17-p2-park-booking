class ParkingsController < ApplicationController
  before_action :set_user, except: %i(index)
  before_action :set_parking, only: %i(show edit update destroy)
  before_action :authenticate_user!, except: %i(index show)
  before_action :set_current_user, only: %i(new edit)

  def index
    @parkings = Parking.all.order_by_time.page(params[:page])
  end

  def new
    @parking = @user.build_parking
  end

  def create
    @parking = @user.build_parking(parking_params)
    @parking.avail_position = params[:parking][:total_position]
    if @parking.save
      flash[:success] = t("parkings.create_park_success")
      redirect_to user_parking_path(@user, @parking)
    else
      flash[:danger] = t("parkings.create_park_fail")
      render :new
    end
  end

  def show
    if !@user.current_user?(current_user) && current_user
      @orders = current_user.orders.find_order(@parking.id, t("parkings.parking"))
    end
  end

  def edit
  end

  def update
    if @parking.update(parking_params)
      @parking.update status: params[:parking][:status]
      flash[:success] = t("parkings.update_park_success")
      redirect_to user_parking_path(@user, @parking)
    else
      flash[:danger] = t("parkings.update_park_fail")
      render :edit
    end
  end

  def destroy
    if @parking.destroy
      flash[:success] = t("parkings.del_park_success")
    else
      flash[:danger] = t("parkings.del_park_fail")
    end
    redirect_to root_url
  end

  private

  def parking_params
    params.require(:parking).permit :name, :waiting_time, :description,
      :total_position, :longitude, :latitude, :address, :time_open,
      :time_close, :price
  end

  def set_user
    @user = User.find_by(id: params[:user_id])
    return if @user
    flash[:danger] = t("users.not_find_user")
    redirect_to root_url
  end

  def set_parking
    @parking = @user.parking
    return if @parking
    flash[:danger] = t("parkings.not_find_park")
    redirect_to root_url
  end

  def set_current_user
    return if @user == current_user
    flash[:danger] = t("parkings.not_have_access_rights")
    redirect_to root_url
  end
end
