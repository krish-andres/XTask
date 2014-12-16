var $div = $('<div class="alert-success j-form" role="alert"><strong>Well done!</strong> You successfully added a Form!</div>');
var overlay = $($div).css({
    position: "absolute",
    width: "100%",
    height: "80%",
    left: 0,
    bottom: 0,
    zIndex: 500,  // to be on the safe side
    "background-color": '#444'
}).appendTo($(".container-form").css("position", "relative"));
overlay.hide();

$('.container-form').on('click', function() {
  overlay.show().delay(1000).fadeOut('slow');
});
  
