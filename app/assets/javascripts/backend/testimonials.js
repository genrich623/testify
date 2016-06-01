$(document).ready(function() {
  $('#new-testimonial-form').hide();

  var newTestimonialFormErrors
     = $('#new-testimonial-form').find($('.has-error')).length;
  var requestTestimonialFormErrors
     = $('#request-testimonial-form').find($('.has-error')).length;

  if (newTestimonialFormErrors !== 0 && requestTestimonialFormErrors === 0) {
    $('#request-testimonial-form').hide();
    $('#new-testimonial-form').show();
  }

  $('#new-testimonial-button').click(function(){
    $('#request-testimonial-button *').fadeTo(1, 0.5);
    $('#request-testimonial-form').hide();
    $('#new-testimonial-button *').fadeTo(1, 1);
    $('#new-testimonial-form').show();
  });

  $('#request-testimonial-button').click(function(){
    $('#new-testimonial-button *').fadeTo(1, 0.5);
    $('#new-testimonial-form').hide();
    $('#request-testimonial-button *').fadeTo(1, 1);
    $('#request-testimonial-form').show();
  });
});
