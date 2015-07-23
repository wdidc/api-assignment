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
  $(".js-time-ago").text(function(){
    var time = moment(this.innerHTML).format('MMMM Do YYYY, h:mm:ss a')
    return time
  })
  $(".status input").change(function(){
    var input = $(this);
    input.prop("disabled", true);
    $.ajax({
      url: input.attr("data-submit"),
      type: "post",
      dataType: "json",
      data: {
        _method: "put",
        submission: {
          id: input.id,
          status: input.checked ? "complete" : "incomplete"
        }
      }
    }).done(function(response){
      console.dir(response);
      input.prop("disabled", false);
    });
  });

  $("[autosave] input").on("change", function( event ){
    var $form = $(event.target).closest("form")
    save($form, function( response ){
      var time = moment(response.updated_at).format('MMMM Do YYYY, h:mm:ss a')
      var $updatedAt = $form.parent().find(".js-updated-at").html( time )
    })
  })

  $("[autosave]").on("keyup", function( event ){
    var self = this
    isTyping(event, function( response ){
      var time = moment(response.updated_at).format('MMMM Do YYYY, h:mm:ssa')
      var $updatedAt = $(self).find(".js-updated-at").html( time )
    })
  })
  var typingTimer
  function isTyping( event, callback ){
      var $form = $(event.target).closest("form")
      clearTimeout(typingTimer)
      typingTimer = setTimeout(function(){
        save( $form, callback )
      }, 2000)
  }
  function save( $form, callback ){
    data = $form.serializeObject()
    if( typeof data["submission[private]"] == "object" ){
      data["submission[private]"] = data["submission[private]"][1]
    }
    data._method = "patch"
    $.ajax({
      url: $form.attr("action"),
      type: "post",
      dataType: "json",
      data: data
    }).always(function(response){
      console.dir(response);
      callback(response)
    });
  }
})
