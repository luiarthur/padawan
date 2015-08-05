---
layout: gfm
---

<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
<link rel="stylesheet" type="text/css" href="/css/fb-comments.css">

# hi
<script>
(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/en_US/sdk.js#xfbml=1&version=v2.4&appId=1406472523010822";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));

  $(document).ready(function(){ // executes js when document is ready. Allows js to be put in head. Good practice.
    var link = window.location.href.replace(/\?fb_comment_id=.*/g,"")
    console.log("here: \n" + link);
    $(".fb-comments").attr("data-href",link).attr("width",$(".fb-comments").width()+"px").attr("colorscheme","dark");
  });
</script>

<div class="fb-comments" colorscheme="dark"></div>
