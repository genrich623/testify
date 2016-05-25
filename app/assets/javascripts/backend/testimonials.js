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
    $('#request-testimonial-form').hide();
    $('#new-testimonial-form').show();
  });

  $('#request-testimonial-button').click(function(){
    $('#new-testimonial-form').hide();
    $('#request-testimonial-form').show();
  });
});
