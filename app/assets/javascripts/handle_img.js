$("input[type='file']").css('color', 'transparent');
$("input[type='file']").change(function() {
  if ($(this).val() != '') {
    $(this).css('color', I18n.t('gray20'));
    $(".current_img").hide();
  } else {
    $(this).css('color', 'transparent');
  }
})
