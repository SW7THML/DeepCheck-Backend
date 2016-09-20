# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready(function() {
  $('#btn-new-post').click(function(e) {
    var id = $(this).data('id');
    if (id) {
      $.ajax('/courses/' + id).success(function(html) {
        $('#modal-post').modal('show')
      });
    }
  });

  $('.photo-detail-link').click(function(e) {
    var cid = $(this).data('course-id');
    var pid = $(this).data('post-id');
    var qid = $(this).data('photo-id');

    if (cid && pid && qid) {
      $.ajax('/courses/' + cid + '/posts/' + pid + '/photos/' + qid).success(function(html) {
        var src = html.photo.url;
        var date = html.date.slice(0, 10);

        document.getElementById("popup-photo").setAttribute("src", src);
        $('#modal-photo').modal('show');
      });
    }
  });
});
