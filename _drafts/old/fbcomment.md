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
  js.src = "//connect.facebook.net/en_US/sdk.js#xfbml=1&version=v2.4&appId=878506195570478";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));
</script>

<div class="fb-com"></div>

<script>
  var link = window.location.href.replace(/\?fb_comment_id=.*/g,"")
  console.log("here: \n" + link);
  //$(".fb-com").attr("data-href",link);
  $(".fb-com").attr("width",$(".fb-com").width()+"px");
  $(".fb-com").attr("colorscheme","dark");
  $(".fb-com").attr("class","fb-comments");
</script>
