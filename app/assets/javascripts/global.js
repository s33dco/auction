jQuery(document).on('turbolinks:load', function() {
  var lots;
  lots = $('#lots');
  lots.on('cocoon:before-insert', function(e, el_to_add) {
    return el_to_add.fadeIn(1000);
  });

  lots.on('cocoon:after-insert', function(e, added_el) {
    added_el.effect('highlight', {}, 500);
    return recount();
  });

  lots.on('cocoon:before-remove', function(e, el_to_remove) {
    $(this).data('remove-timeout', 1000);
    return el_to_remove.fadeOut(1000);
  });

  return lots.on('cocoon:after-remove', function(e, removed_el) {
    return recount();
  });

});


