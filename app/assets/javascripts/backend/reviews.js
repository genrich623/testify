$(document).ready(function() {
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
