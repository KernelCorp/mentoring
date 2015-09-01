class @Slider
  constructor: (selector) ->
    $(document).ready ->
      $(selector).bxSlider
        adaptiveHeight: true
