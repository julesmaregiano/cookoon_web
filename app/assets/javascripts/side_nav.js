$('#side-nav-clicker').click(function() {
  $(".side-nav").show("slide", { direction: "left" }, 500);
})

$('#side-nav-closer').click(function() {
  $(".side-nav").hide("slide", { direction: "left" }, 500);
})
