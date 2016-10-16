function preloadFunc(grid_size) {
  var grids = document.getElementsByClassName('face-grid');

  $('.face-select')
    .css('width', grid_size)
    .css('height', grid_size);

  var offsetY = 47;
  var scaleX = parseFloat($('.photo-attachment').css('width')) * 0.01;
  var scaleY = parseFloat($('.photo-attachment').css('height')) * 0.01;

  for (var i = 0; i < grids.length; ++i) {
    var g = grids[i];
    var grid_width = $(g).attr('width');
    var grid_height = $(g).attr('height');

    $('#' + grids[i].getAttribute('id'))
      .css('width', grid_width * scaleX)
      .css('height', grid_height * scaleY)
      .css('left', $(g).data('x') * scaleX)
      .css('top', $(g).data('y') * scaleY + offsetY);

    $('#' + grids[i].getAttribute('id') + '-date')
      .css('width', grid_width * scaleX)
      .css('left', $(g).data('x') * scaleX)
      .css('top', $(g).data('y') * scaleY + grid_size + offsetY);
  }
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
  var offsetSize = 0.125;
  var grid_size = parseInt($('.photo-attachment').css('width')) * offsetSize;
  var offsetY = -grid_size / 2;
  var offsetX = -grid_size / 2;

  window.onpaint = preloadFunc(grid_size);

  $('.tag-cancel').on("click", function(e) {
    var $this = $(this);
    var pid = $this.data('photo-id');
    var uid = $this.data('user-id');

    tagdelete(pid, uid);
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
      .css('top', y * height * 0.01 + 47);

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
