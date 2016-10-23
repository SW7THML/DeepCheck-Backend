// $(function(){
// 	var width = $('html').css('width');
// 	$('img.photo').height(width);
// });

function fit_photo_list_height(){
	var width = $('html').css('width');
	$('img.photo').height(width);
}

function fit_photo_height() {
	var browserWidth = $('html').css('width');
	var photo = $('img.photo-attachment');
	var photoOriginWidth = photo.data('width');
	var photoOriginHeight = photo.data('height');
	var resolutionRatio = null;
	var photoHeight = null;

	browserWidth = browserWidth.replace("px", '');

	resolutionRatio = browserWidth / photoOriginWidth;
	photoHeight = photoOriginHeight * resolutionRatio;

	photo.height(photoHeight);
}