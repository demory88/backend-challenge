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
//= require_tree .

$(function(){
  $('#user-url').on('blur', function(){
    var url = $('#user-url').val();

    $.ajax({
      type: 'POST',
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer 9ea9c53ac9c6ebdd2e2744aa3d237362d09f2405"
      },
      url: 'https://api-ssl.bitly.com/v4/shorten',
      long_url: url,
      domain: "bit.ly",
      group_guid: "Free: demory88"
    })
    .done(function() {
      console.log('done');
    })
    .fail(function() {
      console.log('fail');
    });
  });
});
