$(function() {
  // Bind le easter egg to le key.
  $(document).bind('keydown', 'r', function assets() {
    console.log('IK HOOR U ZEGGEN!');
    return false;
  });

  // Highly inspired by [this](http://codepen.io/mariusbalaj/pen/MaKRar)
  function parallax(e) {
    var w = window.innerWidth,
        h = window.innerHeight,
        offsetX = 0.5 - e.pageX / w, // Cursor position X
        offsetY = 0.5 - e.pageY / h, // Cursor position Y
        dy = e.pageY - h / 2,
        dx = e.pageX - w / 2,
        theta = Math.atan2(dy, dx), // Angle between cursor and center
        angle = theta * 180 / Math.PI - 90; // Convert rad in degrees

    // Set some shine
    document.querySelector(".shine").style.background = 'linear-gradient(' + angle + 'deg, rgba(255,255,255,' + e.pageY / h / 5 + ') 0%,rgba(255,255,255,0) 80%)';

    // Let the stars move a bit.
    document.querySelector(".stars").style.transform = "translateX(" + offsetX*10 + "px) translateY(" + offsetY*10 + "px)";

    // Make the messages dance
    var messages = document.querySelectorAll(".message");
    Array.prototype.forEach.call(messages, function(el, i){
      el.style.transform = 'rotateX(' + offsetX*5 + 'deg) rotateY(' + offsetY*5 + 'deg)';
    });
  };
  window.addEventListener('mousemove', parallax);
});

