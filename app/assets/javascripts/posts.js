$(document).ready(function() {
  $('.photo').on("click", function(e) {
    $('.face-grid').css('display', "block");
    var offsetY = 34;
    var offsetX = -16;

    var pos = $(this).offset();
    var x = e.pageX - pos.left + offsetX;
    var y = e.pageY - pos.top + offsetY;
    $('.face-grid')
      .css('left', x)
      .css('top', y);
  });

  $('.face-grid').on("click", function(e) {
    var pid = $(this).data('photo-id');
    var uid = 0; //get user id
    if ($('.face-grid').css('display') == "block" )
    {
      var x = $(this).css('left').slice(0, -2) * 1;
      var y = $(this).css('top').slice(0, -2) * 1;
      $.ajax({ 
        type: 'PATCH',
        url: window.location.href + '/photos/' + pid,
        dataType: 'text',
        data: { x: x, y: y, uid : uid },
        success: function(result){
        var src = result.photo.url;
        var date = result.date.slice(0, 10);

      }}); 
    }
  });
});