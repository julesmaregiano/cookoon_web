$('.search-body').hide();
$('.search-header').click(function() {
  $('.search-body').slideToggle();
});

var value = parseInt($('#value').text(), 10);
var max = $('#search_duration').data("max");
var min = $('#search_duration').data("min");

$('.control').click(function() {
  var clickedElem = $(this);
  bumpElement(clickedElem);
  modifyValue(clickedElem);
  setValue();
})

function bumpElement(clickedElem) {
  clickedElem.addClass("bump");
  setTimeout(function() {
    clickedElem.removeClass("bump");
  }, 400);
}

function setValue() {
  $('#value').text(value);
  $('#search_duration').val(value);
}

function modifyValue(clickedElem) {
  if (clickedElem.attr("id") === "min") {
    if ($('#search_duration').val() > min) {
      value -= 1
    }
  }
  else if (clickedElem.attr("id") === "max") {
    if ($('#search_duration').val() < max) {
      value += 1
    }
  }
}
