/*
 * 添加试题 tab切换
 */
$('[data-toggle="tab"]').click(function(){
  var btns = $(this).parent().children('[data-toggle="tab"]');
  btns.removeClass('active');
  $(this).addClass('active');
  btns.each(function(){
    $($(this).data('target')).hide();
  });
  $($(this).data('target')).show();
});