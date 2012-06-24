var slideshow = true;
var slideshow_queue = null;
var slideshow_wait = 2000;
var slideshow_current = 0;

Embassy.SlideShow = {
  init : function(){
    $('.thumbnail').click(function(e){
      e.preventDefault();
      clearTimeout(slideshow_queue);
      slideshow = false;
      Embassy.SlideShow.show($(this));
    });

    slideshow_queue = setTimeout(function(){
      Embassy.SlideShow.move();
    }, slideshow_wait);
  },

  show : function(object){
    name = object.find("img").attr("src").split("/").pop().split("-")[0];
    $('.gallery-image.active').fadeOut(animation_time);
    $('#gallery-' + name).addClass('active').fadeIn(animation_time);
  },

  move : function(){
    if (slideshow == false){ return false; }

    slideshow_current++;
    thumbnail_size = $('#thumbnails .thumbnail').size();
    if ((slideshow_current+1) > thumbnail_size){
      slideshow_current = 0;
    }
    object = $('#thumbnails .thumbnail').eq(slideshow_current);
    this.show(object);

    slideshow_queue = setTimeout(function(){
      Embassy.SlideShow.move();
    }, slideshow_wait)
  }

};
