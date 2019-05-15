module OrdersHelper
  def deadline_day(order, parking)
    return order.day_booked + parking.waiting_time.split(" ").first.to_i*60
  end

  def class_name(object, name)
    return object.class.name == name
  end
end
