$(document).ready(function() {
    $('#submitButton, #backButton').click(function() {
        $(this).closest('form').submit();
    });

    $('.template-link').click(function() {
        $(this).find('form').submit();
    });
});