$('.reservation-option').change(function() {
  compute_price($(this));
})

function compute_price(input) {
  var displayPrice = parseFloat($('#display-price').text());
  var optionPrice = input.data('price');
  if(input.is(":checked")) {
    $('#display-price').text(displayPrice - optionPrice);
  }
  else {
    $('#display-price').text(displayPrice + optionPrice);
  }
}
