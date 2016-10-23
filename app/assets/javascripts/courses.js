function show_modal() {
  $('#modal-post').modal('show');
}

$(document).on('turbolinks:load', function() {
  $('.fa-search').on("click", function(e) {
    var display = $('.search-input').css('display');
    if (display == "inline-block")
      $('.search-input').css('display', 'none');
    else
      $('.search-input').css('display', 'inline-block');
  });

  $('img.photo').load(function(e) {
    if ($(this).data('loaded') == undefined)
    {
      $(this).attr('src', $(this).attr('src').replace('/w_128', '/w_' + parseInt($('html').css('width'))));
      $(this).data('loaded', 'true'); 
    }
  });

  $('#new-post').on("click", function(e) {
    show_modal();
  });

  $('.no-photo').on("click", function(e) {
    show_modal();
  });

  $('input:file').on('change', function(event) {
    var files = event.target.files;
    var image = files[0]
    var file_name = window.FileReader ? image.name : $(this).val().val().split('/').pop().split('\\').pop();

    $(this).siblings('.attachment-label').val(file_name);
    if (typeof(image) == "undefined") {
      document.getElementById("attachment-thumbnail").src = "";
      document.getElementById("attachment-thumbnail").style.display="none";
      document.getElementById("submit").setAttribute('disabled', 'disabled');
    } else {
      var reader = new FileReader();
      reader.onload = function(file) {
        document.getElementById("attachment-thumbnail").src = file.target.result;
        document.getElementById("attachment-thumbnail").style.display="inline-block";
        document.getElementById("submit").removeAttribute('disabled');
      };
      reader.readAsDataURL(image);
    }
  });
});