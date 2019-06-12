class ReviewsController < ApplicationController
  before_action :set_parking
  before_action :set_review, only: %i(edit update destroy)
  before_action :authenticate_user!

  def new
    @order_exist = current_user.orders.find_order(@parking.id, "Parking").first
    @review_exist = @parking.reviews.find_by user_id: current_user.id
    if authorize_add_rv(@review_exist, @order_exist)
      @review = @parking.reviews.new
    else
      flash[:danger] = t("parkings.not_have_access_rights")
      redirect_to root_url
    end
  end

  def create
    @review = @parking.reviews.build review_params
    @review.user_id = current_user.id
    if @review.save
      flash[:success] = t("reviews.add_success")
      redirect_to user_parking_path(@parking.user, @parking)
    else
      flash[:danger] = t("reviews.add_failed")
      render :new
    end
  end

  def edit
  end

  def update
    if @review.update review_params
      flash[:success] = t("reviews.update_success")
      redirect_to user_parking_path(@parking.user, @parking)
    else
      flash[:danger] = t("reviews.update_failed")
      render :edit
    end
  end

  def destroy
    if @review.destroy
      flash[:success] = t("reviews.delete_success")
    else
      flash[:danger] = t("reviews.delete_failed")
    end
    redirect_to user_parking_path(@parking.user, @parking)
  end

  private

  def review_params
    params.require(:review).permit :rating, :comment
  end

  def set_parking
    @parking = Parking.find_by id: params[:parking_id]
    return if @parking
    flash[:danger] = t("parkings.not_find_park")
    redirect_to root_url
  end

  def set_review
    @review = @parking.reviews.find_by id: params[:id]
    return if @review
    flash[:danger] = t("reviews.not_find_review")
    redirect_to root_url
  end
end
