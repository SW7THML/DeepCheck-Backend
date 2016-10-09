$(document).ready(function() {
  var grids = document.getElementsByClassName('face-grid');
  var grid_size = parseInt($('.photo').css('width')) / 8.0;
  var offsetY = -grid_size / 2;
  var offsetX = -grid_size / 2;

  $('.face-select')
    .css('width', grid_size)
    .css('height', grid_size);

  for (var i = 0; i < grids.length; ++i) {
    $('#' + grids[i].getAttribute('id'))
      .css('width', grid_size)
      .css('height', grid_size)
      .css('left', grids[i].getAttribute('data-x') * parseFloat($('.photo').css('width')) * 0.01)
      .css('top', grids[i].getAttribute('data-y') * parseFloat($('.photo').css('height')) * 0.01);

    $('#' + grids[i].getAttribute('id') + '-date')
      .css('width', grid_size)
      .css('left', grids[i].getAttribute('data-x') * parseFloat($('.photo').css('width')) * 0.01)
      .css('top', grids[i].getAttribute('data-y') * parseFloat($('.photo').css('height')) * 0.01 + grid_size);
  }
  
  $('.photo').on("click", function(e) {
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
      data: { x: x, y: y, uid : uid },
      success: function(result){
        location.reload();
    }}); 
  });
});

function tagover(id) {
  $('#grid-' + id)
    .css('border-color', '#ffffff');
  $('#grid-' + id + '-date')
    .css('display', 'block');
}

function tagleave(id) {
  $('#grid-' + id)
    .css('border-color', '#00aaff');
  $('#grid-' + id + '-date')
    .css('display', 'none');
}