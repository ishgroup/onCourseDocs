$(document).ready(function() {
	$('.chapter > .toc').prepend("<gcse:search></gcse:search>");

	window.setTimeout(function() {
  		$('input.gsc-input').attr('placeholder', 'search...');
	} , 1000);
	
});

// Custom search
  (function() {
    var cx = '012973152760557279116:_k5mgzmdgpo';
    var gcse = document.createElement('script');
    gcse.type = 'text/javascript';
    gcse.async = true;
    gcse.src = (document.location.protocol == 'https:' ? 'https:' : 'http:') +
        '//cse.google.com/cse.js?cx=' + cx;
    var s = document.getElementsByTagName('script')[0];
    s.parentNode.insertBefore(gcse, s);
  })();
