$(document).ready(function() {
  var grids = document.getElementsByClassName('face-grid');
  var offsetY = 24;
  var offsetX = -24;

  for (var i = 0; i < grids.length; ++i) {
    $('#' + grids[i].getAttribute('id'))
      .css('left', grids[i].getAttribute('data-x') + 'px')
      .css('top', grids[i].getAttribute('data-y') + 'px');
  }
  
  $('.attendance-cancel').on("click", function(e) {
    var pid = $('.face-select').data('photo-id');
    var uid = $('.face-select').data('user-id');

    $.ajax({
      type: 'DELETE',
      url: window.location.href + '/photos/' + pid,
      success: function(result) {
        location.reload();
      }
    });
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

function tagover(id) {
  $('#grid-' + id)
    .css('border-color', '#ffffff');
}

function tagleave(id) {
  $('#grid-' + id)
    .css('border-color', '#00aaff');
}