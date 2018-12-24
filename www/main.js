$(document).ready(function() {
	$('#lat').prop('disabled',true);
	$('#long').prop('disabled',true);
	$('#mainr').prop('disabled',true);
	$('#appr').prop('disabled',true);
	$('#err').prop('disabled',true);
});

$(document).on('shiny:idle', function(event) {
  in_idlestate();
});

function in_idlestate(){
  //Shiny.onInputChange("cmd", "save");
}