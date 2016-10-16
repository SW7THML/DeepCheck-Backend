$(document).on('turbolinks:load', function() {
  $('#profile-edit').on("click", function(e) {
    window.location.href = window.location.href + '/edit';
  });
});