$(document).ready(function() {
  var grids = document.getElementsByClassName('face-grid');
  for (var i = 0; i < grids.length; ++i) {
    $('#' + grids[i].getAttribute('id'))
      .css('left', grids[i].getAttribute('data-x') + 'px')
      .css('top', grids[i].getAttribute('data-y') + 'px');
  }

  $('.photo').on("click", function(e) {
    $('.face-select').css('display', "block");
    var offsetY = 34;
    var offsetX = -16;

    var pos = $(this).offset();
    var x = e.pageX - pos.left + offsetX;
    var y = e.pageY - pos.top + offsetY;
    $('.face-select')
      .css('left', x)
      .css('top', y);
  });

  $('.face-select').on("click", function(e) {
    var pid = $(this).data('photo-id');
    var uid = $(this).data('user-id');
    if ($('.face-select').css('display') == "block" )
    {
      var x = $(this).css('left').slice(0, -2) * 1;
      var y = $(this).css('top').slice(0, -2) * 1;
      $.ajax({ 
        type: 'PATCH',
        url: window.location.href + '/photos/' + pid,
        dataType: 'text',
        data: { x: x, y: y, uid : uid },
        success: function(result){
          location.reload();
      }}); 
    }
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