var myUserID = null;
var myName = null;
var myPicture = null;
var myUrl = null;
var slug = (window.location.href).replace("index.html","").replace(/\/|\.|:|\[|\]|\#|\$\-/g,"");
var link = "https://luifireapp.firebaseio.com/comments/"+slug;
var replyLink = "https://luifireapp.firebaseio.com/reply/"+slug;
var ref = new Firebase(link);
var replyRef = new Firebase(replyLink);

//var newCommentID = null;
// Store: name, uid, body, picture

//DANGER! REMOVE ALL COMMENTS!
//var temp = new Firebase("https://luifireapp.firebaseio.com");
//temp.auth("SECRET");
//temp.remove();

$(document).ready(function(){ // executes js when document is ready. Allows js to be put in head. Good practice.
});

//$(".oCom[userid='"+uid+"']").children(".editCom").show();
function onLoginClick(provider) {
  event.preventDefault();
  ref.authWithOAuthPopup(provider,function(){});
}
function onLogoutClick(e) {
  e.preventDefault(); //prevents default actions such as going to top of page because: href="#"
  ref.unauth();
  $(".editCom").hide();
  $(".comReply").hide();
}

function genLoginHtml(id, socialMedia) {
  return "<li>" + 
           "<a id='"+id+"' href='#' class='smLogin' onclick='onLoginClick(\""+socialMedia+"\")'>" + 
             "<span class='fa-stack fa-lg'>" + 
               "<i class='fa fa-circle fa-stack-2x'></i>" +
               "<i class='fa fa-"+socialMedia+" fa-stack-1x fa-inverse'></i>" +
             "</span>" +
           "</a>" +
         "</li>";
}
ref.onAuth(function(authData) {
var login =  "<ul class='list-inline text-right'>" +
               genLoginHtml("fbLogin","facebook") +
               genLoginHtml("googleLogin","google") +
               genLoginHtml("githubLogin","github") +
             "</ul>";
/*
  "<img id='githubLogin' href='#' onclick='onLoginClick(\"github\")'   src='/img/github.png'>"+
  "<img id='googleLogin' href='#' onclick='onLoginClick(\"google\")'   src='/img/google.png'>"+ 
  "<img id='fbLogin'     href='#' onclick='onLoginClick(\"facebook\")' src='/img/fb.png'>";
*/

var logout = "<a href='#' onclick='onLogoutClick(event)' id='logout'>logout</a><br>";

  if (authData) {
    myUserID = authData.uid; 

    switch(authData.provider) {
      case "google": 
        myName = authData.google.displayName; 
        myPicture = authData.google.cachedUserProfile.picture;
        myUrl = authData.google.cachedUserProfile.link;
        break;
      case "facebook":
        myName = authData.facebook.displayName; 
        myPicture = authData.facebook.cachedUserProfile.picture.data.url;
        myUrl = authData.facebook.cachedUserProfile.link;
        break;
      case "github":
        myName = authData.github.displayName; 
        myPicture = authData.github.cachedUserProfile.avatar_url;
        myUrl = "https://github.com/"+authData.github.username;
        break;
    }
    $(".oCom[userid='"+myUserID+"']").children(".editCom").show();
    $(".comReply").show();
    $("#logIO").text("").append(logout);
    $("#userPic").attr("src",myPicture);
    //$("#newComment").attr("placeholder",myName+"' s comment...");
    $("#newComment").attr("placeholder","Write a comment...");
  } else {
    $("#logIO").text("").append(login);
    myName=null;
    myUserID=null;
    myPicture="/img/man.jpg";
    $("#userPic").attr("src",myPicture);
    $("#newComment").attr("placeholder","Please login to comment...");
  }
});
$("#newComment").elastic();

function onCommentKeyDown(event) {
  if (event.keyCode == 13) {
    if(myUserID == null) {
      alert("You must log in to leave a comment");
    } else {
      if (event.shiftKey) {
        $("#newComment").val($("#newComment").val()+"\n");
      } else {
          var currTime = new Date();
          currTime = currTime.toString();
          ref.push({userid:myUserID, body:$("#newComment").val(), name:myName, picture:myPicture, time:currTime, url:myUrl});
          $("#newComment").val("");
      }
    }
    event.preventDefault(); // prevents default actions
  }
}

//Create a query for only the last 100 comments
var lastXComments = ref.limitToLast(1000);

//Render Comments
lastXComments.on('child_added', function (snapshot) {
  var comment = snapshot.val();
  var body = comment.body;
  comment.time = jQuery.timeago(new Date(comment.time));
  var newDiv = $("<div/>").addClass("comment").attr("id",snapshot.key()).appendTo("#oldComments");
  newDiv.html(Mustache.to_html($('#template').html(), comment));
  // If the comment owner is logged in, he can view the remove the comment option.
  $(".editCom").hide();
  $(".oCom[userid='"+myUserID+"']").children(".editCom").show();
  if (myUserID === null ) {
    $(".comReply").hide();
  } else {
    $(".comReply").show();
  }
  $("#"+snapshot.key()+" p").replaceWith("<p>"+body.replace(/\n/g,"<br>")+"</p>");
  MathJax.Hub.Queue(["Typeset",MathJax.Hub]); // Reloads MathJax
});

//Remove deleted comments
lastXComments.on("child_removed", function(snapshot) {
  $("#" + snapshot.key()).remove();
});

//Remove Comment
function onClickRemove(e) { 
  var commentID = e.parentNode.parentNode.id;
  var rmRef = new Firebase(link+"/"+commentID);
  rmRef.remove();
}

//Edit Comment:
var eComID = null;
var orig = null;
function onClickEdit(e) {
  //var commentID = e.parentNode.parentNode.id;
  eComID = e.parentNode.parentNode.id;
  var edRef = new Firebase(link+"/"+eComID);
  var loc = $("#"+eComID);
  orig = loc.html();
  var curCom = loc.children("span").children("p");
  var comment = curCom.html().replace(/<br>/g,"\n");
  curCom.replaceWith("<div><textarea id='eCom' onkeydown='onEditKeyDown(event)' class='eCom' style='width:"+
                     ($(".comment").width()-$(".upic").width())+"px;'></textarea></div>");
  var ta = loc.children("span").children("div").children("textarea");
  ta.focus().val("").val(comment);
  $(".eCom").elastic();
  $(".editCom").hide();
  $(".comReply").hide();
}
function onEditKeyDown(e) {
  var edRef = new Firebase(link+"/"+eComID);
  var loc = $("#"+eComID);
  var ta = loc.children("span").children("div").children("textarea");
  if (e.keyCode==13) {
    if (e.shiftKey) {
      $("#eComID").val($("#eComID").val()+"\n");
    } else {
      edRef.child('body').set(ta.val());
      loc.html("").append(orig).children("span").children("p").text(ta.val());
      loc.html("").append(orig).children("span").children("p").replaceWith("<p>"+ta.val().replace(/\n/g,"<br/>")+"</p>");
      $(".oCom[userid='"+myUserID+"']").children(".editCom").show();
      $(".comReply").show();
    }
  }
}

function onCommentClick(e) {
  e.preventDefault();
  if ($("#togComments").attr("show")=="1") {
    $("#oldComments").hide();
    $("#textWrap").hide();
    $("#togComments").attr("show","0");
  } else {
    $("#oldComments").show();
    $("#textWrap").show();
    $("#togComments").attr("show","1");
  }
}

var parentID = null;
function onClickReply(e) {
  //alert("coming soon...");
  $(".comReply").hide();
  parentID = e.parentNode.parentNode.id;
  ptag = "#" + parentID;
  var newDiv = $(ptag).after($("<div/>").addClass("newReply"));
  var reply = {userid:myUserID, name:myName, picture:myPicture, url:myUrl};
  $(".newReply").html(Mustache.to_html($('#replyTemplate').html(), reply));
  $(".newReply").children("span").children(".editCom").hide();
  $(".newReply").children("span").children("p")
    .replaceWith("<textarea id='eCom' onkeydown='onReplyKeyDown(event)' class='eCom' style='width:"+
                 ($(".newReply").width()-$(".upic").width())+"px;'></textarea>");
  $("#eCom").focus();
  $("#eCom").elastic();
}
function onReplyKeyDown(event) {
  if (event.keyCode == 13) {
    if (event.shiftKey) {
      var tag = $(".newReply").children("span").children("textarea");
      tag.val(tag.val()+"\n");
    } else {
        var currTime = new Date();
        currTime = currTime.toString();
        replyRef.push({userid:myUserID, body:$("#eCom").val(), name:myName, picture:myPicture, time:currTime, url:myUrl, commentID: parentID});
        $(".newReply").replaceWith("");
        $(".comReply").show();
    }
    event.preventDefault(); // prevents default actions
  }
}
//Create a query for only the last 100 comments
var lastXReply = replyRef.limitToLast(100);

//Render Comments
lastXReply.on('child_added', function (snapshot) {
  var reply = snapshot.val();
  var body = reply.body;
  reply.time = jQuery.timeago(new Date(reply.time));
  var newDiv = $("<div/>").addClass("reply").attr("id",snapshot.key()).appendTo("#"+reply.commentID);
  newDiv.html(Mustache.to_html($('#replyTemplate').html(), reply));
  // If the reply owner is logged in, he can view the remove the comment option.
  $(".editCom").hide();
  $(".oCom[userid='"+myUserID+"']").children(".editCom").show();
  $("#"+snapshot.key()+" p").replaceWith("<p>"+body.replace(/\n/g,"<br>")+"</p>");
  MathJax.Hub.Queue(["Typeset",MathJax.Hub]); // Reloads MathJax
});

//Remove deleted comments
lastXReply.on("child_removed", function(snapshot) {
  $("#" + snapshot.key()).remove();
});

//Remove Comment
function onClickRemoveReply(e) { 
  var replyID = e.parentNode.parentNode.id;
  var rmRef = new Firebase(replyLink+"/"+replyID);
  rmRef.remove();
}

//Edit Comment:
function onClickEditReply(e) {
  //var commentID = e.parentNode.parentNode.id;
  eComID = e.parentNode.parentNode.id;
  var edRef = new Firebase(replyLink+"/"+eComID);
  var loc = $("#"+eComID);
  orig = loc.html();
  var curCom = loc.children("span").children("p");
  var comment = curCom.html().replace(/<br>/g,"\n");
  curCom.replaceWith("<div><textarea id='eCom' onkeydown='onEditReplyKeyDown(event)' class='eCom' style='width:"+
                     ($(".comment").width()-2*$(".upic").width()-5)+"px;'></textarea></div>");
  var ta = loc.children("span").children("div").children("textarea");
  ta.focus().val("").val(comment);
  $(".eCom").elastic();
  $(".editCom").hide();
  $(".comReply").hide();
}
function onEditReplyKeyDown(e) {
  var edRef = new Firebase(replyLink+"/"+eComID);
  var loc = $("#"+eComID);
  var ta = loc.children("span").children("div").children("textarea");
  if (e.keyCode==13) {
    if (e.shiftKey) {
      $("#eComID").val($("#eComID").val()+"\n");
    } else {
      edRef.child('body').set(ta.val());
      loc.html("").append(orig).children("span").children("p").text(ta.val());
      loc.html("").append(orig).children("span").children("p").replaceWith("<p>"+ta.val().replace(/\n/g,"<br/>")+"</p>");
      $(".oCom[userid='"+myUserID+"']").children(".editCom").show();
      $(".comReply").show();
    }
  }
}
