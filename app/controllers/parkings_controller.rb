class ParkingsController < ApplicationController
  before_action :set_user, except: %i(index)
  before_action :set_parking, only: %i(show edit update destroy)
  before_action :authenticate_user!, except: %i(index show)

  def index
    q = params[:search]
    if q
      @parkings = Parking.search(name_or_address_cont: q).result.page(params[:page]).per(1)
    else
      @parkings = Parking.all.page(params[:page]).per(1)
    end
    respond_to do |format|
      format.js
      format.html
    end
  end

  def new
    if @user == current_user
      @parking = @user.build_parking
    else
      flash[:danger] = t("parkings.not_find_park")
      redirect_to root_url
    end
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
    if @parking.nil?
      flash[:danger] = t("parkings.not_find_park")
      redirect_to root_url
    end
    if @user != current_user && current_user.present?
      @order = Order.where(parking_id: @parking.id, user_id: current_user.id).first
      @review = Review.where(parking_id: @parking.id, user_id: current_user.id).first
    end
    if @parking.reviews.blank?
      @average_review = 0
    else
      @average_review = @parking.reviews.average(:rating).round(2)
    end
  end

  def edit
  end

  def update
    if @parking.update(parking_params)
      @parking.status = params[:parking][:status]
      @parking.save
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
    params.require(:parking).permit(:name, :waiting_time, :description,
      :total_position, :longitude, :latitude, :address, :time_open,
      :time_close, :price)
  end

  def set_user
    @user = User.find_by(id: params[:user_id])
    if @user.nil?
      flash[:danger] = t("users.not_find_user")
      redirect_to root_url
    end
  end

  def set_parking
    @parking = @user.parking
  end
end
