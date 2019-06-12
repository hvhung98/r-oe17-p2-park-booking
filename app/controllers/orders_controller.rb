class OrdersController < ApplicationController
  before_action :set_orderable
  before_action :set_order, only: %i(update)
  before_action :authenticate_user!

  def index
    if check_role_index
      @orders = @orderable.orders.order_by_time.page(params[:page])
      if class_name(@orderable, t("parkings.parking"))
        @orders.each do |order|
          if deadline_day(order, @orderable) < Time.now && order.booked?
            order.canceled!
            if order.user.score != 1
              @orderable.update avail_position: @orderable.avail_position+1
              order.user.update score: order.user.score-3
            end
          end
        end
      end
    else
      flash[:danger] = t("parkings.not_have_access_rights")
      redirect_to root_url
    end
  end

  def new
    @order_exist = current_user.orders.find_order(@orderable.id,
      @orderable.class.name).last
    if @order_exist.nil? || @order_exist.sended? || @order_exist.canceled?
      @order = @orderable.orders.new
    else
      flash[:danger] = t("orders.status_sending")
      redirect_to root_url
    end
  end

  def create
    @order = @orderable.orders.build order_params.merge(user_id: current_user.id)
    if params[:order][:type_booked] == t("orders.date_booked")
      if params[:order][:day_booked] < Time.now
        flash[:danger] = t("orders.date_invalid")
        render :new
        return
      else
        @order.price = @orderable.price
      end
    else
      @order.day_booked = Time.now + 3*86400
      if params[:order][:month_booked].count > 1
        @price = (params[:order][:month_booked].count)*@orderable.price*30
        @order.price = @price - ((10*@price)/100)
      end
    end
    if @order.save
      if current_user.score != 1
        @orderable.update avail_position: @orderable.avail_position-1
      end
      flash[:success] = t("orders.booked_success")
      redirect_to user_orders_path(@order.user)
    else
      flash[:danger] = t("orders.booked_failed")
      render :new
    end
  end

  def update
    if params[:order][:status] == t("booked")
      @order.sending!
      if @order.user.score == 1
        @orderable.update avail_position: @orderable.avail_position-1
      end
    else
      @order.sended!
      @orderable.update avail_position: @orderable.avail_position+1
      if @order.user.score < 10
        @order.user.update score: @order.user.score+3
      end
    end
    flash[:success] = t("orders.update_success")
    redirect_to parking_orders_path(@orderable)
  end

  private

  def order_params
    params.require(:order).permit :car_number, :type_booked, :day_booked,
      month_booked: []
  end

  def set_order
    @order = @orderable.orders.find_by(id: params[:id])
    return if @order
    flash[:danger] = t("orders.not_find_order")
    redirect_to root_url
  end

  def set_orderable
    resource, id = request.path.split("/")[1,2]
    @orderable = resource.singularize.classify.constantize.find(id)
  end

  def check_role_index
    (class_name(@orderable, t("users.user")) && @orderable == current_user) ||
      (class_name(@orderable, t("parkings.parking")) && @orderable.user == current_user)
  end
end
