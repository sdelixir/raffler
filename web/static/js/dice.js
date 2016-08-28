var face=1;

var show = function() {
  $('#cube').attr('class', 'show'+face);
  if(face==6) {
    face=1;
  } else {
    face++;
  }
};

var timer=setInterval("show()", 1500);
