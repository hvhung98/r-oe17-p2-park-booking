function check(value) {
  if(value == I18n.t('orders.date_booked')) {
    $('#date_booked').show();
    $('#year_booked').hide();
    $('#now_year').hide();
    $('#next_year').hide();
  } else if(value == I18n.t('orders.month_booked')) {
    $('#date_booked').hide();
    $('#year_booked').show();
  } else {
    $('#date_booked').hide();
    $('#year_booked').hide();
    $('#now_year').hide();
    $('#next_year').hide();
  }
}
function select_year(year) {
  if(year == I18n.t('now')) {
    $('#now_year').show();
    $('#next_year').hide();
  } else {
    $('#now_year').hide();
    $('#next_year').show();
  }
}
