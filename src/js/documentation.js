$(document).ready(function() {
  $('body').addClass('page-loaded');
  setTimeout(function() {
    $('body').addClass('is-loaded');
  }, 1000);

  $('#header').before('\
    <header class="navbar">\
      <div class="container clearfix">\
        <div class="navbar-header">\
          <a href="/" class="navbar-brand">\
            <img src="images/logo.png" alt="logo">\
          </a>\
        </div>\
      </div>\
    </header>\
  ');

  // $('.book > #header').wrap('<div id="top-header" />');
  $('body #content').wrap('<div id="main-container" class="clearfix container" />');
  $('body #main-container').wrap('<div class="documentation-wrapper" />');

  var toc = $('#header #toc');
  if (toc.length) {
    $('#main-container').append('<div class="sidebar-toc"><div id="toc" class="toc2">' + toc.clone().html() + '</div> </div>');
  }

  $('#toc ul').addClass('nav');
  $('#toc ul li a').addClass('nav-link');

  $('.sect1 h2').each(function(){
    var me = $(this);
    me.html(me.html().replace(/(^(?:\S+\s+\n?){1,2})/, '<span class="htext-highlighted">$1</span>'));
  });

  $('body').scrollspy({ target: "#toc" });

  var hash = window.location.hash;
  if (hash !== "") {
    setTimeout(function() {
      $('.sidebar-toc #toc a[href="' + hash + '"].nav-link')[0].click();
    }, 300);
  }

  $(window).on('scroll', function() {
    var scrollTop = $(this).scrollTop();

    $('#toc .hasChildren').removeClass('toc-open');
    $($('#toc .hasChildren .nav-link.active').parents('li.hasChildren:not(.toc-open)').toggleClass('toc-open'));

    $('#header #toc .nav-link').removeClass('current');
    $('#header #toc .active').last().addClass('current');

    var mainContainer = $('#main-container');
    var sidebarToc = $('.sidebar-toc');
    if (mainContainer && sidebarToc.length && sidebarToc[0].offsetHeight > 0) {
      var mainContainer_offsetTop = mainContainer[0].offsetTop;

      if (scrollTop > mainContainer_offsetTop) {
        $('body').addClass('affix-toc-sidebar');
        $('#toc').addClass('nav-visible');
      } else {
        $('body').removeClass('affix-toc-sidebar');
        $('#toc').removeClass('nav-visible');
      }
    } else {
      $('body').removeClass('affix-toc-sidebar');
    }

    // display nav on mobile after 400 scroll from top
    if (scrollTop > 500) {
      $('#toc').addClass('nav-visible');
    } else {
      $('#toc').removeClass('nav-visible');
    }

  });

  // click to expand mobile navigation
  $('.sectlevel0').click(function() {
    $(this).parent().toggleClass("nav-expanded");
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
  if (host) {
    $('a[href^="https://demo.cloud.oncourse.cc"]').each(function () {
      $(this).attr('href', $(this).attr('href').replace('demo.cloud.oncourse.cc', host));
      $(this).text( $(this).text().replace('demo.cloud.oncourse.cc', host));
    });
  }

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
