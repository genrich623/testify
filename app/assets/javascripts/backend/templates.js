$(document).ready(function() {
  $('.testimonial-template-field').val($('.testimonial-template-thumbs').first().data('template-id'));

  active_template($('.testimonial-template-thumbs').first());

  $('.testimonial-template-thumbs').click(function() {
    $('.testimonial-template-field').val($(this).data('template-id'));
    active_template($(this));
  });

  function active_template($selector){
    $('.testimonial-template-thumbs').css('border-style', 'none');
    $selector.css('border-style', 'solid');
    $selector.css('border-width', '5px');
    $selector.css('border-color', '#54a8cb');
  }
});
