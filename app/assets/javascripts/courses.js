$(document).ready(function() {
  $('#btn-new-post').on("click", function(e) {
    var id = $(this).data('id');
    if (id) {
      $('#modal-post').modal('show');
    }
  });


  $('#popup-photo').on("click", function(e) {
    var offset = $(this).offset();
    var x = e.pageX - offset.left;
    var y = e.pageY - offset.top;
    $('#face-grid')
      .css('left', x)
      .css('top', y);

    $.ajax('/courses/' + cid + '/posts/' + pid + '/photos/' + qid + '/tags?id=' + userid + '&x=' + x + '&y=' + y).success(function(json) {
      var src = html.photo.url;
      var date = html.date.slice(0, 10);

      document.getElementById("popup-photo").setAttribute("src", src);
      $('#modal-photo').modal('show');
    });
  });

  $('#post_attachment').on('change', function(event) {
    var files = event.target.files;
    var image = files[0]
    var reader = new FileReader();
    reader.onload = function(file) {
      document.getElementById("thumbnail").src = file.target.result;
      document.getElementById("thumbnail").style.display="inline-block";
      document.getElementById("submit").style.display="inline-block";
    }
    reader.readAsDataURL(image);
  });
});