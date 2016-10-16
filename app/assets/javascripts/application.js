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
//= require_self
//= require_tree .


$(document).ready(function() {
  var standalone = window.navigator.standalone,
  userAgent = window.navigator.userAgent.toLowerCase(),
  safari = /safari/.test( userAgent ),
  ios = /iphone|ipod|ipad/.test( userAgent );

  console.log(standalone);
  console.log("ios", ios);
  console.log("safari", safari);
  console.log("standalone", standalone);

  if( ios ) {
    if ( !standalone && safari ) {
      //browser
      $('.navigation-header').addClass('ios-nav');
      $('.main-container').addClass('ios-nav');
    } else if ( standalone && !safari ) {
      //standalone
      $('.navigator-header').addClass('ios-nav');
      $('.main-container').addClass('ios-nav');
    } else if ( !standalone && !safari ) {
      //uiwebview
      $('.navigation-header').addClass('ios-nav');
      $('.main-container').addClass('ios-nav');
    };
  } else {
    //not iOS
  };
})

$(document).ready(function() {
  $('.ion-ios-arrow-back').click(function(e) {
    window.history.back();
    console.log("back");
    e.preventDefault();
    return false;
  })
})