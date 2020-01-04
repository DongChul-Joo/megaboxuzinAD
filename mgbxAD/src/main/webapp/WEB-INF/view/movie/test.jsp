<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
movieNm = "백두산 예고편";

$.ajax({
	  dataType: "json",
	  url: 
	    'https://www.googleapis.com/youtube/v3/search'+
	    '?part=snippet'+
	    '&maxResults=5'+
	    '&order=viewCount'+
	    '&q='+movieNm+
	    '&type=video'+
	    '&videoDefinition=high'+
	    '&key=AIzaSyChPQ7wyJdU2QcGXf3DJqeqAy4uHhdRdLA'
	    
	}).done(function(data){
	    /* Initial */
	    var tag = document.createElement('script');
	    tag.src = "https://www.youtube.com/iframe_api";
	    var firstScriptTag = document.getElementsByTagName('script')[0];
	    firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

	    var player;
	    
	    onYouTubeIframeAPIReady = function(event){
	        player = new YT.Player('youtube-player', {
	            videoId: data.items[0].id.videoId
	        });
	    }
	    
	   /* $('#video-title').text(data.items[0].snippet.title);
	    
	     List 
	    var length = data.items.length;
	    
	    for(var i=0; i<length; i++){
	        var item = data.items[i];
	        var videoThumb = item.snippet.thumbnails.medium.url;
	        var videoTitle = item.snippet.title;
	        
	        li = '<li>'+                    
	             '<img src="'+videoThumb+'" class="thumb">'+
	             '<p class="title"><span class="outer"><span class="inner">'+videoTitle+'</span></span></p>'+
	             '</li>';
	        $('ul').append(li);
	    }
	    */
	 });


	<%-- 
function movieVideo(movieNm){
	var movieNm= movieNm+"티져";
	var url ="<%=cp%>/movie/movieVideo";
	var query="movieNm="+encodeURIComponent(movieNm)
	$.ajax({
		 type:"post"
		  ,url: url
		  ,data:query
	      ,dataType:"json"
	      ,success:function(data){
	        console.log(data);
	       }
	
		}).done(function(data){
		    /* Initial */
		    var tag = document.createElement('script');
		    tag.src = "https://www.youtube.com/iframe_api";
		    var firstScriptTag = document.getElementsByTagName('script')[0];
		    firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

		    var player;
		    
		    onYouTubeIframeAPIReady = function(event){
		        player = new YT.Player('youtube-player', {
		            videoId: data.items[0].id.videoId
		        });
		    }
		    
		    $('#video-title').text(data.items[0].snippet.title);
		    $('#youtube-list').mCustomScrollbar({theme: 'dark'});
		    
		    /* List */
		    var length = data.items.length;
		    
		    for(var i=0; i<length; i++){
		        var item = data.items[i];
		        var videoThumb = item.snippet.thumbnails.medium.url;
		        var videoTitle = item.snippet.title;
		        
		        li = '<li>'+                    
		                            '<img src="'+videoThumb+'" class="thumb">'+
		                            '<p class="title"><span class="outer"><span class="inner">'+videoTitle+'</span></span></p>'+
		                    '</li>';
		        $('ul').append(li);
		    }
		    
		 });	
 --%>		



</script>




</head>
<body>


<div class="youtube">
  <div class="youtube-selected">
    <div id="youtube-player"></div>
  </div>
</div>

</body>
</html>