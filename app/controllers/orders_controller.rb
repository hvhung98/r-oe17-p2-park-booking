class OrdersController < ApplicationController
  before_action :set_parking
  before_action :set_order, only: %i(show edit update)
  before_action :authenticate_user!
  def index
    if current_user = @parking.user
      @orders = @parking.orders
      @orders.each do |order|
        if ((order.day_booked + @parking.waiting_time.split(" ").first.to_i*60 < Time.now) &&
          (order.status == "Đã đặt"))
          order.status = "Đã gửi"
          order.save
          if order.user.score != 1
            @parking.avail_position += 1
            @parking.save
            order.user.score -= 3
            order.user.save
          end
        end
      end
    else
      flash[:danger] = "Bạn không có quyền truy cập trang này"
      redirect_to root_url
    end
  end

  def new
    @order = @parking.orders.build
  end

  def create
    @order = @parking.orders.build
    if params[:order][:type_booked] == "Đặt theo ngày"
      if params[:order][:day_booked] < Time.now
        flash[:danger] = "Ngày đặt không hợp lệ"
        redirect_to user_parking_path(@parking.user, @parking)
      else
        @order.day_booked = params[:order][:day_booked]
        @order.month_booked = ""
        @order.price = @parking.price
        @order.type_booked = params[:order][:type_booked]
        @order.car_number = params[:order][:car_number]
        @order.user_id = current_user.id
        if @order.save
          if current_user.score != 1
            @parking.avail_position -= 1
            @parking.save
          end
          flash[:success] = "Đặt chỗ thành công"
          redirect_to parking_order_path(@parking, @order)
        else
          flash[:danger] = "Đặt chỗ không thành công"
          render :new
        end
      end
    else
      @order = @parking.orders.build(order_params)
      @order.day_booked = Time.now + 3*86400
      @order.type_booked = params[:order][:type_booked]
      if params[:order][:month_booked].count > 1
        @price = (params[:order][:month_booked].count)*@parking.price*30
        @order.price = @price - ((10*@price)/100)
      end
      @order.car_number = params[:order][:car_number]
      @order.user_id = current_user.id
      if @order.save
        if current_user.score != 1
          @parking.avail_position -= 1
          @parking.save
        end
        flash[:success] = "Đặt chỗ thành công"
        redirect_to parking_order_path(@parking, @order)
      else
        flash[:danger] = "Đặt chỗ không thành công"
        render :new
      end
    end

  end


  def show
  end


  def edit
  end

  def update
    if params[:order][:status] == "Đã đặt"
      @order.status = "Đang gửi"
      if @order.user.score == 1
        @parking.avail_position -= 1
        @parking.save
      end
    else
      @order.status = "Đã gửi"
      @parking.avail_position += 1
      @parking.save
      if @order.user.score < 10
        @order.user.score += 3
        @order.user.save
      end
    end
    @order.save
    redirect_to parking_orders_path(@parking)
  end

  private

  def order_params
    params.require(:order).permit(month_booked: [])
  end

  def set_parking
    @parking = Parking.find_by(id: params[:parking_id])
    if @parking.nil?
      flash[:danger] = "Bãi đỗ không hợp lệ"
      redirect_to root_url
    end
  end

  def set_order
    @order = @parking.orders.find_by(id: params[:id])
    if @order.nil?
      flash[:danger] = "Order không tồn tại"
      redirect_to root_url
    end
  end
end
