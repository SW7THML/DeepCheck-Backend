$(document).ready(function() {

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
      document.getElementById("thumbnail").src = file.target.result;
      document.getElementById("thumbnail").style.display="inline-block";
      document.getElementById("submit").style.display="inline-block";
    }
    reader.readAsDataURL(image);
  });
});

function tagged(id) {
  $('#post-' + id).find('.panel-footer').css('background-color', '#5cb85c');

}