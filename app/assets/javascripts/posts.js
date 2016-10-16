function preloadFunc(grid_size) {
  var grids = document.getElementsByClassName('face-grid');
  var scaleX = parseFloat($('.photo-attachment').css('width')) * 0.01;
  var scaleY = parseFloat($('.photo-attachment').css('height')) * 0.01;

  $('.face-select')
    .css('width', grid_size)
    .css('height', grid_size);

  $(".face-grid").each(function () {
    $(this)
      .css('width', $(this).attr('width') * scaleX)
      .css('height', $(this).attr('height') * scaleY)
      .css('left', $(this).data('x') * scaleX)
      .css('top', $(this).data('y') * scaleY);
  });
}

function tagdelete(pid, uid) {
  $.ajax({
    type: 'DELETE',
    url: window.location.href + '/photos/' + pid,
    data: { uid : uid },
    success: function(result) {
      location.reload();
    }
  });
}

function photoLoaded() {
  var photo = $('.photo-attachment');
  var offsetSize = 0.125;
  var grid_size = parseInt(photo.css('width')) * offsetSize;

  var offsetY = -grid_size / 2;
  var offsetX = -grid_size / 2;

  window.onpaint = preloadFunc(grid_size);

  $('.tag-cancel').on("click", function(e) {
    var $this = $(this);
    var pid = $this.data('photo-id');
    var uid = $this.data('user-id');

    tagdelete(pid, uid);
  });

  $('.face-grid').on("click", function(e) {
    var pid = $(this).data('photo-id');
    var uid = $('.face-select').data('user-id');
    var tid = $(this).data('tag-id');
    
    $.ajax({ 
      type: 'PATCH',
      url: window.location.href + '/photos/' + pid,
      dataType: 'text',
      data: { tid: tid, uid: uid },
      success: function(result) {
        location.reload();
      }
    }); 
  });

  $('.photo-attachment').on("click", function(e) {
    var pos = $(this).offset();

    var width = parseFloat($(this).css('width'));
    var height = parseFloat($(this).css('height'));
    var x = (e.pageX - pos.left + offsetX) / width * 100;
    var y = (e.pageY - pos.top + offsetY) / height * 100;

    var pid = $('.face-select').data('photo-id');
    var uid = $('.face-select').data('user-id');

    $('.face-select')
      .css('display', "block")
      .css('left', x * width * 0.01)
      .css('top', y * height * 0.01);

    $.ajax({ 
      type: 'PATCH',
      url: window.location.href + '/photos/' + pid,
      dataType: 'text',
      data: { x: x, y: y, width: grid_size / width * 100, height: grid_size / height * 100, uid : uid },
      success: function(result) {
        location.reload();
      }
    }); 
  });
}

$(document).ready(function() {
  $('.photo-attachment').load(function() {
    photoLoaded();
  });
});
