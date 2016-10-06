$(document).ready(function() {
  var grids = document.getElementsByClassName('face-grid');
  var offsetY = 24;
  var offsetX = -24;

  for (var i = 0; i < grids.length; ++i) {
    $('#' + grids[i].getAttribute('id'))
      .css('left', grids[i].getAttribute('data-x') * parseInt($('.photo').css('width')) * 0.01)
      .css('top', grids[i].getAttribute('data-y') * parseInt($('.photo').css('height')) * 0.01);

    $('#' + grids[i].getAttribute('id') + '-date')
      .css('left', grids[i].getAttribute('data-x') + 'px')
      .css('top', grids[i].getAttribute('data-y') * 1 + 50 + 'px');
  }
  
  $('.photo').on("click", function(e) {
    var pos = $(this).offset();
    var x = (e.pageX - pos.left + offsetX) / parseInt($(this).css('width')) * 100;
    var y = (e.pageY - pos.top + offsetY) / parseInt($(this).css('height')) * 100;

    var pid = $('.face-select').data('photo-id');
    var uid = $('.face-select').data('user-id');

    $('.face-select')
      .css('display', "block")
      .css('left', x * parseInt($(this).css('width')) * 0.01)
      .css('top', y * parseInt($(this).css('height')) * 0.01);

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