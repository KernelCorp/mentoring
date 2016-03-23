class @Datetimepicker
  constructor: (selector) ->
    $(document).ready ->
      $(selector).datetimepicker
        lang: 'ru'
        minDate: new Date
        yearStart: new Date().getFullYear()
        yearEnd: new Date().getFullYear() + 1
        dayOfWeekStart: 1
        step: 30
        inline: true
