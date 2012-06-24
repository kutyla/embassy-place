$(document).keyup(function(e){
  if (e.keyCode == 27) {
    Embassy.Modal.stop();
    Embassy.Modal.close();
    return false;
  };
});

Embassy.Modal = {
  open : function(){
    Embassy.Modal.stop();
    $(modal).animate({ "top" : "0%" }, animation_time);
  },

  close : function(){
    Embassy.Modal.stop();
    $(modal).animate({ "top" : "100%" }, animation_time);
  },

  stop : function(){
    $(modal).stop();
  }

};
