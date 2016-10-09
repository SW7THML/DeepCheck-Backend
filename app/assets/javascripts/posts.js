$(document).ready(function() {
  var grids = document.getElementsByClassName('face-grid');
  var offsetY = 24;
  var offsetX = -24;

  for (var i = 0; i < grids.length; ++i) {
    $('#' + grids[i].getAttribute('id'))
      .css('left', grids[i].getAttribute('data-x') + 'px')
      .css('top', grids[i].getAttribute('data-y') + 'px');
  }
  
  $('.tag-cancel').on("click", function(e) {
    var $this = $(this);
    var pid = $this.data('photo-id');
    var uid = $this.data('user-id');

    tagdelete(pid, uid);
  });

  $('.attendance-cancel').on("click", function(e) {
    var face_select = $('.face-select');
    var pid = face_select.data('photo-id');
    var uid = face_select.data('user-id');

    tagdelete(pid, uid);
  });

  $('.photo').on("click", function(e) {
    var pos = $(this).offset();
    var x = e.pageX - pos.left + offsetX;
    var y = e.pageY - pos.top + offsetY;
    var pid = $('.face-select').data('photo-id');
    var uid = $('.face-select').data('user-id');

    $('.face-select')
      .css('display', "block")
      .css('left', x)
      .css('top', y);

    $.ajax({ 
      type: 'PATCH',
      url: window.location.href + '/photos/' + pid,
      dataType: 'text',
      data: { x: x, y: y, uid : uid },
      success: function(result) {
        location.reload();
      }
    }); 
  });
});

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