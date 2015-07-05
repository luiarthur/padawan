var myUserID = null;
var myName = null;
var myPicture = null;
var myUrl = null;
var slug = (window.location.href).replace("index.html","").replace(/\/|\.|:|\[|\]|\#|\$\-/g,"");
var link = "https://luifireapp.firebaseio.com/comments/"+slug;
var ref = new Firebase(link);

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
  ref.authWithOAuthPopup(provider,function(){});
}
function onLogoutClick(e) {
  e.preventDefault(); //prevents default actions such as going to top of page because: href="#"
  ref.unauth();
  $(".oCom").children(".editCom").hide();
}

ref.onAuth(function(authData) {
var login = "<img id='githubLogin' href='#' onclick='onLoginClick(\"github\")'   src='logos/github.png'>"+
            "<img id='googleLogin' href='#' onclick='onLoginClick(\"google\")'   src='logos/google.png'>"+ 
            "<img id='fbLogin'     href='#' onclick='onLoginClick(\"facebook\")' src='logos/fb.png'>";
var logout = "<a href='#' onclick='onLogoutClick(event)' id='logout'>logout</a>";

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
    $("#logIO").text("").append(logout);
    $("#userPic").attr("src",myPicture);
    $("#newComment").attr("placeholder",myName+"' s comment...");
  } else {
    $("#logIO").text("").append(login);
    myName=null;
    myUserID=null;
    myPicture="img/man.jpg";
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
var lastXComments = ref.limitToLast(100);

//Render Comments
lastXComments.on('child_added', function (snapshot) {
  var comment = snapshot.val();
  comment.time = jQuery.timeago(new Date(comment.time));
  var newDiv = $("<div/>").addClass("comment").attr("id",snapshot.key()).appendTo("#oldComments");
  newDiv.html(Mustache.to_html($('#template').html(), comment));
  // If the comment owner is logged in, he can view the remove the comment option.
  $(".oCom").children(".editCom").hide();
  $(".oCom[userid='"+myUserID+"']").children(".editCom").show();
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
  console.log(orig);
  var curCom = loc.children("span").children("text");
  loc.children("span").replaceWith("<div class='twrap'><textarea id='eCom' onkeydown='onEditKeyDown(event)' class='commentBox' style='border:1px solid;'></textarea></div>");
  loc.after("<p style='clear:both'></p>");
  var ta = loc.children("div").children("textarea");
  ta.focus().val("").val(curCom.text());
  $(".commentBox").elastic();
}
function onEditKeyDown(e) {
  var edRef = new Firebase(link+"/"+eComID);
  var loc = $("#"+eComID)
  var ta = loc.children("div").children("textarea");
  if (e.keyCode==13) {
    edRef.child('body').set(ta.val());
    loc.html("").append(orig).children("span").children("text").text(ta.val());
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
// Only give remove options to those that have access.
// Show remove options on mouseover.
// http://www.w3schools.com/jquery/jquery_events.asp
