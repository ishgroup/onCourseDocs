$(document).ready(function() {
	$('.chapter > .toc').prepend("<gcse:search></gcse:search>");

  $('head').append('<style type="text/css">.gsc-adBlock, .gsc-resultsHeader, .gcsc-branding {display: none !important;}</style>');

  $('.toc > dl.toc > dd > dl > dt').click(function(e) {
    if (e.offsetX < 15) {  /* only detect clicks on the triangle icon */
      $(this).toggleClass('expand').next().toggle();
      return false;
    }
  });

  $('.toc > dl.toc > dd > dl > dd').hide();

  // set college host if we have a cookie for it
  let host = readCookie('oncourse_host');
  $('a[href^="http://demo.cloud.onncourse.cc"]').each(function () {
    $(this).attr('href', $(this).attr('href').replace('demo.cloud.onncourse.cc', host));
    $(this).text( $(this).text().replace('demo.cloud.onncourse.cc', host));
  });


  // need to wait until Google draws the search box
	window.setTimeout(function() {
  		$('input.gsc-input').attr('placeholder', 'search...');
	} , 1000);

});

function readCookie(name) {
  var nameEQ = name + "=";
  var ca = document.cookie.split(';');
  for(var i=0;i < ca.length;i++) {
    var c = ca[i];
    while (c.charAt(0)==' ') c = c.substring(1,c.length);
    if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
  }
  return null;
}

// Custom search
  (function() {
    const cx = '012973152760557279116:_k5mgzmdgpo';
    const gcse = document.createElement('script');
    gcse.type = 'text/javascript';
    gcse.async = true;
    gcse.src = (document.location.protocol === 'https:' ? 'https:' : 'http:') +
        '//cse.google.com/cse.js?cx=' + cx;
    const s = document.getElementsByTagName('script')[0];
    s.parentNode.insertBefore(gcse, s);
  })();
