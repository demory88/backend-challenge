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
//= require select2
//= require_tree .

$(function(){
  $(".select2").select2({
    allowClear: true,
    theme: "bootstrap"
  });

  $('.shorten-me').on('blur', function(){
    var url = $('#user_url').val();
    var accessToken = "9ea9c53ac9c6ebdd2e2744aa3d237362d09f2405";
    var params = {
      "long_url" : url
    };

    $.ajax({
      // This API is very finnicky, worth considering a replacement
      url: "https://api-ssl.bitly.com/v4/shorten",
      cache: false,
      dataType: "json",
      method: "POST",
      contentType: "application/json",
      beforeSend: function (xhr) {
        xhr.setRequestHeader("Authorization", "Bearer " + accessToken);
      },
      data: JSON.stringify(params)
    })
    .done(function(response) {
      console.log('done');
      $('#user_short_url').val(response.link);
      console.log($('#user_short_url').val());
    })
    .fail(function() {
      console.log('fail');
    });
  });
});
