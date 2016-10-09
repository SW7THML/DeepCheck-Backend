$(document).ready(function() {

  $('.fa-search').on("click", function(e) {
    var display = $('.search-input').css('display');
    if (display == "inline-block")
      $('.search-input').css('display', 'none');
    else
      $('.search-input').css('display', 'inline-block');
  });

  $('#btn-new-post').on("click", function(e) {
    var id = $(this).data('id');
    if (id) {
      $('#modal-post').modal('show');
    }
  });

  $('#post_attachment').on('change', function(event) {
    var files = event.target.files;
    var image = files[0]
    var reader = new FileReader();
    reader.onload = function(file) {
      document.getElementById("attachment-thumbnail").src = file.target.result;
      document.getElementById("attachment-thumbnail").style.display="inline-block";
      document.getElementById("submit").style.display="inline-block";
    }
    reader.readAsDataURL(image);
  });
});