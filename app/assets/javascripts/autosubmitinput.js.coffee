class @AutoSubmitInput
  constructor: (selector) ->
    $(document).ready ->
      $(selector).on 'change', ->
        this.closest('form').submit()
