
$(document).ready(function(){ // executes js when document is ready. Allows js to be put in head. Good practice.
  (function(d, s, id) {
    var js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) return;
    js = d.createElement(s); js.id = id;
    js.src = "//connect.facebook.net/en_US/sdk.js#xfbml=1&version=v2.4&appId=878506195570478";
    fjs.parentNode.insertBefore(js, fjs);
  }(document, 'script', 'facebook-jssdk'));

  var link = window.location.href.replace(/\?fb_comment_id=.*/g,"")
  console.log("website: \n" + link);
  $(".fb-comments").attr("data-href",link).attr("width",$(".fb-comments").width()+"px").attr("colorscheme","dark");
});
