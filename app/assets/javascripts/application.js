// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$.fn.serializeObject = function()
{
    var o = {};
    var a = this.serializeArray();
    $.each(a, function() {
        if (o[this.name] !== undefined) {
            if (!o[this.name].push) {
                o[this.name] = [o[this.name]];
            }
            o[this.name].push(this.value || '');
        } else {
            o[this.name] = this.value || '';
        }
    });
    return o;
};

$(function(){
  $(".status input").change(function(){
    $.ajax({
      url: $(this).attr("data-submit"),
      type: "post",
      dataType: "json",
      data: {
	_method: "put",
	submission: {
	  id: this.id,
	  status: this.checked ? "complete" : "incomplete"
	}
      }
    }).always(function(response){
      console.dir(response);
    });
  });


  $("[autosave]").on("keyup", isTyping)
  var typingTimer
  var isTyping = function isTyping( event ){
      clearTimeout(typingTimer)
      typingTimer = setTimeout(doneTyping, 5000)
  }
  var doneTyping = function doneTyping(){
    var $form = $(this).find("form")
    $.ajax({
      url: $form.attr("action"),
      type: "post",
      dataType: "json",
      data: {
	_method: "patch",
	submission: $form.serializeObject()
      }
    }).always(function(response){
      console.dir(response);
    });
  }
})
