
ready = ->
  today = new Date

  $('.selection.dropdown').dropdown()
  $('.datepicker').datetimepicker
    lang: 'ru'
    inline: true
    minDate: today

$(document).ready ready
$(document).on 'page:load', ready
