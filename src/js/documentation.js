$(document).ready(function() {
	// $('.book #header > #toc').prepend("<gcse:search></gcse:search>");

  $('#toc ul').addClass('nav');
  $('#toc ul li a').addClass('nav-link');

  $('body').scrollspy({ target: "#toc" });

  $(window).on('scroll', function() {
    $('#toc .hasChildren').removeClass('toc-open');
    $($('#toc .hasChildren .nav-link.active').parents('li.hasChildren:not(.toc-open)').find('.toc-expand')).trigger('click');
  });

  $('head').append('<style type="text/css">.gsc-adBlock, .gsc-resultsHeader, .gcsc-branding {display: none !important;}</style>');

  $('#toc ul.sectlevel0 ul.sectlevel1 > li').each(function(i, v) {
    if($(v).find('.sectlevel2').length) {
      $(v).find('.sectlevel2').parent().addClass('hasChildren');
      $(v).find('.sectlevel2').parent().find('>a').after('<span class="toc-expand"></span>');
    }
  });

  $(document).on("click", '#toc .toc-expand', function(e) {
    $(this).parent().toggleClass('toc-open');
  });

  // set college host if we have a cookie for it
  let host = readCookie('oncourse_host');
  $('a[href^="https://demo.cloud.oncourse.cc"]').each(function () {
    $(this).attr('href', $(this).attr('href').replace('demo.cloud.oncourse.cc', host));
    $(this).text( $(this).text().replace('demo.cloud.oncourse.cc', host));
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
