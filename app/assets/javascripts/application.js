//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require semantic-ui
//= require jquery.datetimepicker
//= require_tree .

var ready = function() {
    $('tr[data-link]').click(function() {
        window.location = this.dataset.link
    })
};

$(document).ready(ready);
$(document).on('page:load', ready);
