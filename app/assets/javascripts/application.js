// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require jquery.raty.js

//= require rails-ujs
//= require activestorage

//= require_tree .
//= require jcanvas

/*global $*/
/*global gon*/

$(document).ready(function () {
  $(".main-view").skippr({
    transition : 'fade',
    speed : 1000,
    easing : 'easeOutQuart',
    navType : 'block',
    childrenElementType : 'div',
    arrows : true,
    autoPlay : true,
    autoPlayDuration : 3000,
    keyboardOnAlways : true,
    hidePrevious : false
  });
});

// Enterで次に進まないように
$(function(){
  $("input").on("keydown", function(e) {
    if ((e.which && e.which === 13) || (e.keyCode && e.keyCode === 13)) {
      return false;
    } else {
      return true;
    }
  });
});


// 星表示


$(document).on('turbolinks:load', function () {
  var data = gon.trimmers
  var array = data, i = 0, len = array.length;
  while (i < len) {
    $(".average-rate" + array[i] ).empty();
    $(".average-rate" + array[i] ).raty({
      readOnly: true,
      cancelOff: '/cancel-off.png',
      cancelOn: '/cancel-on.png',
      starHalf: '/star-half.png',
      starOff: '/star-off.png',
      starOn: '/star-on.png',
      score: function() {
        return $(this).attr('data-score');
      },
    });
    console.log(array[i++]);
  }
});

