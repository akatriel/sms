// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require materialize-sprockets
//= require materialize.clockpicker
//= require_tree .

$(document).on('turbolinks:load', function() {
	$('#openModal').click( function(){
		$('.modal').modal({
			dismissible: true
		});
	});
	$('.timepicker').pickatime({
	    default: 'now',
		twelvehour: false, // change to 12 hour AM/PM clock from 24 hour
		donetext: 'OK',
		autoclose: false,
		vibrate: true, // vibrate the device when dragging clock hand
	});
	$('#saveBTN').click(function(){
		var startTime = $('#startTime').val();
		var finishTime = $('#finishTime').val();

		$('#start_time').val(startTime);
		$('#finish_time').val(finishTime);
	});
	Materialize.updateTextFields();
});