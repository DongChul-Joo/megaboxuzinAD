<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>


<script type="text/javascript">

jQuery(function(){
	   jQuery("#btnMovie").click(function(){
		  var directorName = jQuery("#director").val();
		  var movieName= jQuery("#movieTitle").val();
		  var url="<%=cp%>/movie/movieInfo";
	      var query="movieNm="+encodeURIComponent(movieName)+"&directorNm="+encodeURIComponent(directorName);
		
	      
	      
	      jQuery.ajax({
	         type:"post"
	         ,url:url
	         ,data:query
	         ,dataType:"json"
	         ,success:function(data){
	            console.log(data);
	         // console.log(data.movieListResult.movieList[0].movieNm);
	         	jQuery("#movieList").empty(); 
	         	
	         	for(var i=0; i<data.movieListResult.movieList.length; i++){
	         		var tag;
	         		var movieTitle= data.movieListResult.movieList[i].movieNm;
	         		var movieCd= data.movieListResult.movieList[i].movieCd;
	         		tag="<tr style='height:35px;'><td><a href='javascript:detailMovie(\""+movieCd+"\");'>"+"영화제목 :"+movieTitle;
	         		
				for(var j=0; j<data.movieListResult.movieList[i].directors.length; j++){
	        	  		
		        	  	var director = data.movieListResult.movieList[i].directors[j].peopleNm;
		        	  	
		        	  	tag+="&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp"+"| 감독 명 :"+director+"</a></td>";
	        	  	}
	        	  	
	        	  	tag+="</tr>">
	        	  		
	        	  	jQuery("#movieList").append(tag);
	          }
	         
	          
	         }
	         ,error:function(e){
	            console.log(e.responseText);
	         }
	      });
	      
	   });
	   
});  

function detailMovie(movieCd){
	var url="<%=cp%>/movie/movieDetail";
	var query="movieCd="+movieCd;
	    
	
	      jQuery.ajax({
	         type:"get"
	         ,url:url
	         ,data:query
	         ,dataType:"json"
	         ,success:function(data){
	            console.log(data);
	            
	            showTime="";
				movieOpen="";
				country="";
				prdtYear="";
	            movieNm="";
			
	            movieNm= data.movieInfoResult.movieInfo.movieNm;
				country = data.movieInfoResult.movieInfo.nations[0].nationNm
	        	
	        	var director="";
	        	if(data.movieInfoResult.movieInfo.directors.length > 0){
		        	for(var i=0; i<data.movieInfoResult.movieInfo.directors.length; i++){
		            	director +=data.movieInfoResult.movieInfo.directors[i].peopleNm+"/";
		        	}
		            	
		        	jQuery("input[name=moviedirector]").val(director);
	        	} else {
	        		jQuery("input[name=moviedirector]").val("unknown");
	        	}
	        	
	        	var showType="";
	        	if(data.movieInfoResult.movieInfo.showTypes.length> 0){
		            for(var i=0; i<data.movieInfoResult.movieInfo.showTypes.length; i++){
		            	showType += data.movieInfoResult.movieInfo.showTypes[i].showTypeGroupNm+"("
		        	  		+data.movieInfoResult.movieInfo.showTypes[i].showTypeNm+")/\n";
		            }
		           		 jQuery("textarea[name=showing]").val(showType);
		            
	        	} else {
	        		jQuery("textarea[name=showing]").val("unknown");
	        	}
	        	
	            var limit="";
	            if(data.movieInfoResult.movieInfo.audits.length > 0){
		            for(var i=0; i<data.movieInfoResult.movieInfo.audits.length; i++){
		        		limit =data.movieInfoResult.movieInfo.audits[0].watchGradeNm;
		            }
		            jQuery("input[name=audits]").val(limit);
	            } else {
	            	jQuery("input[name=movieLimit]").val("unknown");
	            }
		            
	        	
	            var actors="";
	        	for(var i=0; i<data.movieInfoResult.movieInfo.actors.length; i++){
	        	  	actors += data.movieInfoResult.movieInfo.actors[i].peopleNm+"/";
	        	  
	            }
	            
	        	var production="";
	        	if(data.movieInfoResult.movieInfo.companys.length >0 ){
		        	for(var i=0; i<data.movieInfoResult.movieInfo.companys.length; i++){
		        		production += data.movieInfoResult.movieInfo.companys[0].companyNm+"/";
		            }
		        	 
		        	jQuery("input[name=production]").val(production);
	        	} else {
		        	jQuery("input[name=production]").val("unknown");

	        	}
				
	        	var prdtYear="";
	        	
	        	prdtYear = data.movieInfoResult.movieInfo.prdtYear;
	        	 	
			    jQuery("input[name=mcreated]").val(prdtYear);
	           
	            
	            var genre="";
	            if(data.movieInfoResult.movieInfo.genres.length > 0){
		            for(var i=0; i<data.movieInfoResult.movieInfo.genres.length; i++){
		            	genre +=data.movieInfoResult.movieInfo.genres[i].genreNm+"/" ;
		            }
		            jQuery("input[name=genre]").val(genre);
	            } else {
	            	jQuery("input[name=genre]").val("unknown");
	            }
	            
	            if(data.movieInfoResult.movieInfo.showTm > 0){
		            showTime= data.movieInfoResult.movieInfo.showTm+"분";
	            	
		            jQuery("input[name=mtime]").val(showTime);
	            } else {
	            	jQuery("input[name=mtime]").val("unknown");
	            }
	          	
	            
	            
	            if(data.movieInfoResult.movieInfo.openDt >0){
	            	movieOpen = data.movieInfoResult.movieInfo.openDt   
	            	
	            	jQuery("input[name=openDate]").val(movieOpen);
	            } else {
	            	jQuery("input[name=openDate]").val("unknown");
	            }
				
		        jQuery("input[name=movieCode]").val(movieCd);
		        jQuery("input[name=movieNm]").val(movieNm);
		        jQuery("textarea[name=actor]").val(actors);
		        jQuery("input[name=country]").val(country);
		       
	         	
		        getMovieTitle(movieNm, prdtYear,country);
		       
	         }
	         ,error:function(e){
	            console.log(e.responseText);
	        
	         }
	   });
}



function changeCode(text){
	var code;
	
	if(text == "한국"){
		code = "KR";
	} else if(text == "일본") {
		code = "JP";
	} else if(text == "미국"){
		code = "US";
	} else if(text == "홍콩"){
		code = "HK";
	} else if(text == "영국"){
		code = "GB";
	} else if(text == "프랑스"){
		code = "FR";
	} else if(text == "기타"){
		code = "ETC";
	}
	
	
	return code;
}

function getMovieTitle(movieTitle, year, country) {
	var url="<%=cp%>/movie/movieImage";
	var query="movieTitle="+encodeURIComponent(movieTitle)+"&year="+year+"&country="+changeCode(country);

	jQuery.ajax({
        type:"get"
        ,url:url
        ,data:query
        ,dataType:"json"
        ,success:function(data){
           console.log(data);
       		if(data.items.length > 0){
       			var movieImage= data.items[0].image;
       			
       			jQuery("input[name=thumbNail]").val(movieImage);
       		} else {
       			jQuery("input[name=thumbNail]").val("No images");
       		}
           
           
           
        }
        ,error:function(e){
           console.log(e.responseText);
       
        }
  });
	
	          	
};
	          	
function submitMovie(){
	        var f = document.movieForm;
	
	    	var str = f.movieCode.value;
	        if(!str) {
	            alert("영화코드를 입력하세요. ");
	            f.movieCode.focus();
	            return;
	        }

	        str = f.movieNm.value;
	        if(!str) {
	            alert("영화제목을 입력하세요. ");
	            f.movieNm.focus();
	            return;
	        }
	        
	        str = f.audits.value;
	        if(!str) {
	            alert("영화등급을 입력하세요. ");
	            f.audits.focus();
	            return;
	        }
	        
	        str = f.thumbNail.value;
	        if(!str) {
	            alert("썸네일 주소를 입력하세요. ");
	            f.thumbNail.focus();
	            return;
	        }
	        
	        str = f.movieStory.value;
	        if(!str) {
	            alert("줄거리를 입력하세요. ");
	            f.movieStory.focus();
	            return;
	        }
	        
	        str = f.openDate.value;
	        if(!str) {
	            alert("개봉일을 입력하세요. ");
	            f.openDate.focus();
	            return;
	        }
	        
	        str = f.startDate.value;
	        if(!str) {
	            alert("상영시작일 입력하세요. ");
	            f.startDate.focus();
	            return;
	        }
	        
	        str = f.endDate.value;
	        if(!str) {
	            alert("상영종료일 입력하세요. ");
	            f.endDate.focus();
	            return;
	        }
	        
	    	f.action="<%=cp%>/movie/${mode}";

	        f.submit();
	
}

function resetMovie(){
	jQuery(".movieForm").empty();
	
	
}



</script>

    

<style>
td, tr{
list-style: none;
}


</style>



<div style="width:800px; margin: 0px auto;">
	<div class="body-title" style="margin: 0px auto;">
        <h3><i class="fas fa-chalkboard"></i> 영화 등록 </h3>
    </div>

	<form name="movieForm" method="post">
		<table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;">
				 <tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
				 	
				     <td width="100" bgcolor="#eeeeee" style="text-align: center;">영&nbsp;&nbsp;화&nbsp;&nbsp;명</td>
				     
				 	 <td style="padding-left:10px;"> 
						<input id="movieTitle" type="text" placeholder="영화 제목"/><button class=btn type="button" id="btnMovie" style="margin-left: 25px;" >영화 검색</button>
					 </td> 
					 
				</tr>
				
				<tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
				     <td width="100" bgcolor="#eeeeee" style="text-align: center;">감&nbsp;&nbsp;독&nbsp;&nbsp;명</td>
				 	 <td style="padding-left:10px;"> 
						<input id="director" type="text" placeholder="영화 감독"/>
					 </td> 
				</tr>
			</table>
			<br>
			
			<div style="width: 100%; min-height: 10px;">
				<h3>영화 선택</h3>
				<table id="movieList" style="width: 100%; height: 100%'">
				
				</table>
			</div>
			<br>
			
			<table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;">
				<tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
				     <td width="100" bgcolor="#eeeeee" style="text-align: center;">영&nbsp;화&nbsp;코&nbsp;&nbsp;드</td>
				 	 <td style="padding-left:10px;"> 
						<input name="movieCode" type="text" style="width: 200px;">
					 </td> 
				</tr>
				
				<tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
				     <td width="100" bgcolor="#eeeeee" style="text-align: center;">영&nbsp;&nbsp;화&nbsp;&nbsp;명</td>
				 	 <td style="padding-left:10px;"> 
						<input name="movieNm" type="text" style="width: 200px;">
					 </td> 
				</tr>
				
				<tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
				     <td width="100" bgcolor="#eeeeee" style="text-align: center;">감&nbsp;&nbsp;독&nbsp;&nbsp;명</td>
				 	 <td style="padding-left:10px;"> 
						<input name="moviedirector" type="text" style="width: 200px;">
					 </td> 
				</tr>
				
				<tr align="left" height="110" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
				     <td width="100" bgcolor="#eeeeee" style="text-align: center;">출&nbsp;연&nbsp;진&nbsp;&nbsp;</td>
				 	 <td style="padding-left:10px;"> 
						<textarea name="actor" style="width: 250px; height: 95px;"/></textarea>
					 </td> 
				</tr>
				
				<tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
				     <td width="100" bgcolor="#eeeeee" style="text-align: center;">장&nbsp;&nbsp;&nbsp;&nbsp;르</td>
				 	 <td style="padding-left:10px;"> 
						<input name="genre" type="text" style="width: 200px;">
					 </td> 
				</tr>
				
				<tr align="left" height="110" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
				     <td width="100" bgcolor="#eeeeee" style="text-align: center;">상&nbsp;영&nbsp;분&nbsp;&nbsp;류</td>
				 	 <td style="padding-left:10px;"> 
						<textarea name="showing" style="width: 250px; height: 95px;"/></textarea>
					 </td> 
				</tr>
				
				<tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
				     <td width="100" bgcolor="#eeeeee" style="text-align: center;">영&nbsp;화&nbsp;등&nbsp;&nbsp;급</td>
				 	 <td style="padding-left:10px;"> 
						<input name="audits" type="text" style="width: 200px;">
					 </td> 
				</tr>
				
				<tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
				     <td width="100" bgcolor="#eeeeee" style="text-align: center;">제&nbsp;&nbsp;작&nbsp;&nbsp;사</td>
				 	 <td style="padding-left:10px;"> 
						<input name="production" type="text" style="width: 200px;">
					 </td> 
				</tr>
				
				<tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
				     <td width="100" bgcolor="#eeeeee" style="text-align: center;">제&nbsp;작&nbsp;년&nbsp;&nbsp;도</td>
				 	 <td style="padding-left:10px;"> 
						<input name="mcreated" type="text" style="width: 200px;">
					 </td> 
				</tr>
				
				<tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
				     <td width="100" bgcolor="#eeeeee" style="text-align: center;">상&nbsp;영&nbsp;시&nbsp;&nbsp;간</td>
				 	 <td style="padding-left:10px;"> 
						<input name="mtime" type="text" style="width: 200px;">
					 </td> 
				</tr>
				
				
				
				<tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
				     <td width="100" bgcolor="#eeeeee" style="text-align: center;">제&nbsp;작&nbsp;국&nbsp;&nbsp;가</td>
				 	 <td style="padding-left:10px;"> 
						<input name="country" type="text" style="width: 200px;">
					 </td> 
				</tr>
				
				<tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
				     <td width="100" bgcolor="#eeeeee" style="text-align: center;">썸&nbsp;네&nbsp;일&nbsp;&nbsp;</td>
				 	 <td style="padding-left:10px;"> 
						<input name="thumbNail" type="text" style="width: 200px;">
					 </td> 
				</tr>
				
				<tr align="left" height="110" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
				     <td width="100" bgcolor="#eeeeee" style="text-align: center;">줄&nbsp;&nbsp;거&nbsp;&nbsp;리</td>
				 	 <td style="padding-left:10px;"> 
						<textarea name="movieStory" style="width: 500px; height: 95px;"></textarea>
					 </td> 
				</tr>
				
				<tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
				     <td width="100" bgcolor="#eeeeee" style="text-align: center;">개&nbsp;봉&nbsp;날&nbsp;&nbsp;짜</td>
				 	 <td style="padding-left:10px;"> 
						<input name="openDate" type="text" style="width: 200px;">
					 </td> 
				</tr>
				
				<tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
				     <td width="100" bgcolor="#eeeeee" style="text-align: center;">상&nbsp;영&nbsp;시&nbsp;작&nbsp;일(ex:20191227)</td>
				 	 <td style="padding-left:10px;"> 
						<input name="startDate" type="text"  style="width: 200px;">
					 </td> 
				</tr>
				
				
				<tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
				     <td width="100" bgcolor="#eeeeee" style="text-align: center;">상&nbsp;영&nbsp;종&nbsp;료&nbsp;일(ex:20200127)</td>
				 	 <td style="padding-left:10px;"> 
						<input name="endDate" type="text"  style="width: 200px;">
					 </td> 
				</tr>
				</table>
				
				
				<table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
			     	<tr height="45"> 
			      		<td align="center" >
			        		<button type="button" onclick="submitMovie();">${mode=='update'?'수정완료':'등록하기'}</button>
			        		<button type="reset" name="resetMovie">다시입력</button>
				 		</td>
			    	</tr>
			  </table>
		</form>
</div>







