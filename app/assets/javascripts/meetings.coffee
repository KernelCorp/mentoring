
ready = ->
  today = new Date

  $('select.dropdown').dropdown()
  $('.datepicker').datetimepicker
    lang: 'ru'
    inline: true
    minDate: today

$(document).ready ready
$(document).on 'page:load', ready
