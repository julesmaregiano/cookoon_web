$('#side-nav-clicker').click(function() {
  $('.overlay').fadeIn();
  $('.side-nav').show('slide', { direction: 'left' }, 500);
})

$('#side-nav-closer').click(function() {
  $('.overlay').fadeOut();
  $('.side-nav').hide('slide', { direction: 'left' }, 500);
})
