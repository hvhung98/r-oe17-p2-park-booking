module OrdersHelper
  def deadline_day(order, parking)
    order.day_booked + parking.waiting_time.split(" ").first.to_i*60
  end

  def class_name(object, name)
    object.class.name == name
  end

  def authorize_add_rv(review, order)
    review.nil? && order.present? && order.sended?
  end
end
