var TagRequest = function(){
};

TagRequest.prototype.serverRequest = function(type, url, data, success) {
  $.ajax({
    type: type,
    url: url,
    data: data,
    dataType: 'json',
    success: function(response) {
      if (response.status == "success") {
        success(response.data);
      }
    }
  });
};

TagRequest.prototype.getTags = function(photo_id) {
  var url = '/photos/' + photo_id + '/tags';
  var data = null;

  this.serverRequest('GET', url, data, function(tags) {
    renderTags(tags);
  });
};

TagRequest.prototype.createTags = function(photo_id, x, y, width, height) {
  var url = '/photos/' + photo_id + '/tags';
  var data = {
    x: x,
    y: y,
    width: width,
    height: height,
  }

  this.serverRequest('POST', url, data, function(tags) {
    renderTags(tags);
  });
};

TagRequest.prototype.updateTag = function(photo_id, tag_id) {
  var url = '/photos/' + photo_id + '/tags/' + tag_id;
  var data = null;

  this.serverRequest('PATCH', url, data, function(tags) {
    renderTags(tags);
  });
};

TagRequest.prototype.removeTag = function(photo_id, tag_id) {
  var url = '/photos/' + photo_id + '/tags/' + tag_id;
  var data = null;

  this.serverRequest('DELETE', url, data, function(tags) {
    renderTags(tags);
  });
};

// var Grid = function(){
// };

activeGrid = function(tag_id){
  $('#grid-' + tag_id)
    .removeClass('tag-leaved')
    .addClass('tag-selected');
};

deactiveGrid = function(tag_id){
  $('#grid-' + tag_id)
    .removeClass('tag-selected')
    .addClass('tag-leaved');
};

function renderTags(tags) {
  $('.face-grid').remove();
  $('.tag').remove();

  var scaleX = parseFloat($('.photo-attachment').css('width')) * 0.01;
  var scaleY = parseFloat($('.photo-attachment').css('height')) * 0.01;

  $.each(tags, function(i, tag){
    var $face = null;
    var aElement = '';
    var nameElement = null;
    var spanElement = null;
    var tagElement = null;

    $face = $('<div class="face-grid" id="grid-' + tag.id +'" />');
    $face.css({
      left: tag.x * scaleX,
      top: tag.y * scaleY,
      width: tag.width * scaleX,
      height: tag.height * scaleY
    });

    $('.photo img').after($face);

    if(tag.user) {
      var $tag = $('<div class="tag" />');
      $tag.attr("data-tag-id", tag.id);

      var $tagName = $('<span class="tag-name">' + tag.user.name + '</span>');

      $tag.append($tagName);

      if (tag.delete)
      {
        var $tagCancel = $('<span class="tag-cancel" />');
        var $tagDelete = $('<a class="tag-delete" />');
        var $tagIcon = $('<span class="ionicons ion-ios-close-outline" aria-hidden="true" />');

        $tagCancel.append($tagDelete);
        $tagCancel.append($tagIcon);

        $tag.append($tagCancel);
      }

      $('.tags').append($tag);
    }
  });
}

$(document).on('turbolinks:load', function() {
  $('.photo-attachment').load(function() {
    var tagRequest = new TagRequest();

    var photo_id = $(this).parent().data('photo-id');

    var offsetSize = 0.125;
    var grid_size = parseInt($(this).css('width')) * offsetSize;
    var offsetY = -grid_size / 2;
    var offsetX = -grid_size / 2;

    tagRequest.getTags(photo_id);

    $('.tags').on("click", '.tag-cancel', function(e) {
      var tag_id = $(this).parent().data('tag-id');
      tagRequest.removeTag(photo_id, tag_id);
    });

    $('.photo').on("click", '.face-grid', function(e) {
      var tag_id = $(this).attr('id').slice(5);
      tagRequest.updateTag(photo_id, tag_id);
    });

    $('.photo-attachment').on("click", function(e) {
      var pos = $(this).offset();

      var width = parseFloat($(this).css('width'));
      var height = parseFloat($(this).css('height'));
      var grid_size = parseInt(width) * offsetSize;

      var x = (e.pageX - pos.left + offsetX) / width * 100;
      var y = (e.pageY - pos.top + offsetY) / height * 100;

      width = grid_size / width * 100;
      height = grid_size / height * 100;

      tagRequest.createTags(photo_id, x, y, width, height);
    });
  });

  $('.tags').on("mouseenter", ".tag", function (e) {
    $(this).find('.tag-name')
      .addClass('tag-selected')
      .removeClass('tag-removed');
    activeGrid($(this).data("tag-id"));
  });

  $('.tags').on("mouseleave", ".tag", function (e) {
    $(this).find('.tag-name')
      .removeClass('tag-selected')
      .addClass('tag-removed');
    deactiveGrid($(this).data("tag-id"));
  });
});