$(document).ready(function() {
  $('#new-review-form').hide();

  var newReviewFormErrors
     = $('#new-review-form').find($('.has-error')).length;
  var requestReviewFormErrors
     = $('#request-review-form').find($('.has-error')).length;

  if (newReviewFormErrors !== 0 && requestReviewFormErrors === 0) {
    $('#request-review-form').hide();
    $('#new-review-form').show();
  }

  $('#new-review-button').click(function(){
    $('#request-review-button *').fadeTo(1, 0.5);
    $('#request-review-form').hide();
    $('#new-review-button *').fadeTo(1, 1);
    $('#new-review-form').show();
  });

  $('#request-review-button').click(function(){
    $('#new-review-button *').fadeTo(1, 0.5);
    $('#new-review-form').hide();
    $('#request-review-button *').fadeTo(1, 1);
    $('#request-review-form').show();
  });

  for (var i = 0; i < $('#review-rating').val(); i++) {
    var $currentElement = $('.review-rating-stars').eq(i);
    $currentElement.addClass('fa-star').removeClass('fa-star-o');
  }

  $('.review-rating-field').val(0);

  $('.review-rating-stars').click(function() {
    $('.review-rating-field').val($(this).data('rating'));

    $('.review-rating-stars').addClass('fa-star-o').removeClass('fa-star');

    for (var i = 0; i <= $(this).index(); i++) {
      var $currentElement = $('.review-rating-stars').eq(i);
      $currentElement.addClass('fa-star').removeClass('fa-star-o');
    }
  });
});
