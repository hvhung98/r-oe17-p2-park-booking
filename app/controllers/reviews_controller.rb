class ReviewsController < ApplicationController
  before_action :set_parking
  before_action :set_review, only: %i(edit update destroy)

  def new
    @review = @parking.reviews.build
  end

  def create
    @review = current_user.reviews.build(review_params)
    @review.parking_id = @parking.id
    @review.user_id = current_user.id
    if @review.save
      flash[:success] = "Thêm đánh giá thành công"
    else
      flash[:danger] = "Thêm đánh giá thất bại"
    end
    redirect_to user_parking_path(@parking.user, @parking)
  end

  def edit
  end

  def update
    if @review.update(review_params)
      flash[:success] = "Cập nhật đánh giá thành công"
      redirect_to user_parking_path(@parking.user, @parking)
    else
      flash[:danger] = "Cập nhật đánh giá thất bại"
      render :edit
    end
  end

  def destroy
    if @review.destroy
      flash[:success] = "Xóa đánh giá thành công"
    else
      flash[:danger] = "Xóa đánh giá thất bại"
    end
    redirect_to user_parking_path(@parking.user, @parking)
  end

  private

  def review_params
    params.require(:review).permit(:rating, :comment)
  end

  def set_parking
    @parking = Parking.find_by(id: params[:parking_id])
    if @parking.nil?
      flash[:danger] = "Bãi đỗ không hợp lệ"
      redirect_to root_url
    end
  end

  def set_review
    @review = @parking.reviews.find_by(id: params[:id])
    if @review.nil?
      flash[:danger] = "Review không hợp lệ"
      redirect_to root_url
    end
  end
end
