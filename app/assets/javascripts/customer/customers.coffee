# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $("#customer_post_code").jpostal({
    postcode : [ "#customer_post_code" ],
    address  : {
                  "#customer_prefecture_code" : "%3",
                  "#customer_city"            : "%4",
                  "#customer_street"          : "%5%6%7"
                }
  })