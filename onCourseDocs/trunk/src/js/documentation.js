let version;
let availableVersions = ['8.0', '9.0', '9.12', 'latest'];

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

  try {
    version = window.location.href.match(/doc\/(.*?)\//)[1];

    if ( $.isNumeric(version) ) {
      availableVersions.push(version);
      // and dedupe
      availableVersions = availableVersions.filter(function(item, pos) {
        return availableVersions.indexOf(item) === pos;
      });
    }

    let versionsHtml = "";
    availableVersions.sort().forEach(function(v) {
      versionsHtml = versionsHtml + "<a href='" + window.location.href.replace(/\/doc\/.*?\//,"/doc/" + v + "/") + "' class='btn";
      if (v === version) {
        versionsHtml = versionsHtml + " active";
      }
      versionsHtml = versionsHtml + "'>" + v + "</a>";
    });

    $('.navheader').prepend("<div class='versions'>Documentation version " + versionsHtml + "</div>");

  } catch(e) {}





  // need to wait until Google draws the search box
	window.setTimeout(function() {
  		$('input.gsc-input').attr('placeholder', 'search...');
	} , 1000);

});

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
