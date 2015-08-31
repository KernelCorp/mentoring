class @Datetimepicker
  constructor: (selector) ->
    $(document).ready ->
      $(selector).datetimepicker
        lang: 'ru'
        inline: true
        minDate: new Date
