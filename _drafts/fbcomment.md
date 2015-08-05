---
layout: gfm
---

<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>

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
    $(".fb-com").attr("data-href",link).attr("data-numposts","5").attr("class","fb-comments").attr("style","background-color:#E9DBEF ; border-radius: 10px; margin-top:15px;")
  });
</script>

<div class="fb-com"></div>
