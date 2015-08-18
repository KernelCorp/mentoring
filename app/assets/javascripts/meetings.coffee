# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  today = new Date

  $('.selection.dropdown').dropdown()
  $('.datepicker').datetimepicker
    lang: 'ru'
    inline: true
    minDate: today

$(document).ready ready
$(document).on 'page:load', ready
