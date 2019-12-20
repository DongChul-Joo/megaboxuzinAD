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
	            
	            var movieNm= data.movieInfoResult.movieInfo.movieNm;
	            
	            var director = "";
	            for(var i=0; i<data.movieInfoResult.movieInfo.directors.length; i++){
	        	  	director +=data.movieInfoResult.movieInfo.directors[i].peopleNm;
	            }
	            
	            
	            for(var i=0; i<data.movieInfoResult.movieInfo.showTypes.length; i++){
	        	  	var showTypeGroupNm =data.movieInfoResult.movieInfo.showTypes[i].showTypeGroupNm;
	        	  	var showTypeNm = data.movieInfoResult.movieInfo.showTypes[i].showTypeNm;
	        	  
	            }
	            
	            var limit="";
	            for(var i=0; i<data.movieInfoResult.movieInfo.audits.length; i++){
	        	  	limit +=data.movieInfoResult.movieInfo.audits[i].watchGradeNm;
	            }
	            
	            var production= data.movieInfoResult.movieInfo.companys[0].companyNm;
	           
	            var prdtYear = data.movieInfoResult.movieInfo.prdtYear;
	            
	            var genre="";
	            for(var i=0; i<data.movieInfoResult.movieInfo.genres.length; i++){
	        	  	
	            	genre +=data.movieInfoResult.movieInfo.genres[i].genreNm;
	        	  	
	            }
	            
	            
	            var showTime= data.movieInfoResult.movieInfo.showTm;
	           
				var movieOpen = data.movieInfoResult.movieInfo.openDt            
	            
				var country = data.movieInfoResult.movieInfo.nations[0].nationNm
				
		        jQuery("input[name=movieCode]").val(movieCd);
		        jQuery("input[name=title]").val(movieNm);
		        jQuery("input[name=moviedirector]").val(director);
		        jQuery("input[name=showing]").val(showTypeGroupNm);
		        jQuery("input[name=showingDetail]").val(showTypeNm);
		        jQuery("input[name=movieLimit]").val(limit);
		        
		        jQuery("textarea[name=production]").val(production);
		        jQuery("textarea[name=genre]").val(genre);
		        jQuery("input[name=mcreated]").val(prdtYear);
		        jQuery("input[name=mtime]").val(showTime);
		        jQuery("input[name=mstartDate]").val(movieOpen);
		        jQuery("input[name=country]").val(country);
	         
	         }
	         ,error:function(e){
	            console.log(e.responseText);
	        
	         }
	      
	   });
	
	
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



	<form action="">
		<table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;">
				 <tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
				 	
				     <td width="100" bgcolor="#eeeeee" style="text-align: center;">영&nbsp;&nbsp;화&nbsp;&nbsp;명</td>
				     
				 	 <td style="padding-left:10px;"> 
						<input id="movieTitle" type="text" placeholder="영화 제목"/><button type="button" id="btnMovie">영화 검색</button>
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
						<input name="movieCode" type="text"/>
					 </td> 
				</tr>
				
				<tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
				     <td width="100" bgcolor="#eeeeee" style="text-align: center;">영&nbsp;&nbsp;화&nbsp;&nbsp;명</td>
				 	 <td style="padding-left:10px;"> 
						<input name="title" type="text"/>
					 </td> 
				</tr>
				
				<tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
				     <td width="100" bgcolor="#eeeeee" style="text-align: center;">감&nbsp;&nbsp;독&nbsp;&nbsp;명</td>
				 	 <td style="padding-left:10px;"> 
						<input name="moviedirector" type="text"/>
					 </td> 
				</tr>
				
				<tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
				     <td width="100" bgcolor="#eeeeee" style="text-align: center;">장&nbsp;&nbsp;&nbsp;&nbsp;르</td>
				 	 <td style="padding-left:10px;"> 
						<textarea name="genre"></textarea>
					 </td> 
				</tr>
				
				<tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
				     <td width="100" bgcolor="#eeeeee" style="text-align: center;">상&nbsp;영&nbsp;분&nbsp;&nbsp;류</td>
				 	 <td style="padding-left:10px;"> 
						<input name="showing" type="text"/>
					 </td> 
				</tr>
				
				<tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
				     <td width="100" bgcolor="#eeeeee" style="text-align: center;">분&nbsp;류&nbsp;상&nbsp;&nbsp;세</td>
				 	 <td style="padding-left:10px;"> 
						<input name="showingDetail" type="text"/>
					 </td> 
				</tr>
				
				<tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
				     <td width="100" bgcolor="#eeeeee" style="text-align: center;">영&nbsp;화&nbsp;등&nbsp;&nbsp;급</td>
				 	 <td style="padding-left:10px;"> 
						<input name="movieLimit" type="text"/>
					 </td> 
				</tr>
				
				<tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
				     <td width="100" bgcolor="#eeeeee" style="text-align: center;">제&nbsp;&nbsp;작&nbsp;&nbsp;사</td>
				 	 <td style="padding-left:10px;"> 
						<textarea name="production"></textarea>
					 </td> 
				</tr>
				
				<tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
				     <td width="100" bgcolor="#eeeeee" style="text-align: center;">제&nbsp;작&nbsp;년&nbsp;&nbsp;도</td>
				 	 <td style="padding-left:10px;"> 
						<input name="mcreated" type="text"/>
					 </td> 
				</tr>
				
				<tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
				     <td width="100" bgcolor="#eeeeee" style="text-align: center;">상&nbsp;영&nbsp;시&nbsp;&nbsp;간</td>
				 	 <td style="padding-left:10px;"> 
						<input name="mtime" type="text"/>
					 </td> 
				</tr>
				
				<tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
				     <td width="100" bgcolor="#eeeeee" style="text-align: center;">개&nbsp;봉&nbsp;날&nbsp;&nbsp;짜</td>
				 	 <td style="padding-left:10px;"> 
						<input name="mstartDate" type="text"/>
					 </td> 
				</tr>
				
				<tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
				     <td width="100" bgcolor="#eeeeee" style="text-align: center;">제&nbsp;작&nbsp;국&nbsp;&nbsp;가</td>
				 	 <td style="padding-left:10px;"> 
						<input name="country" type="text"/>
					 </td> 
				</tr>
				
				<tr align="left" height="80" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
				     <td width="100" bgcolor="#eeeeee" style="text-align: center;">줄&nbsp;&nbsp;거&nbsp;&nbsp;리</td>
				 	 <td style="padding-left:10px;"> 
						<textarea name="mstory"></textarea>
					 </td> 
				</tr>
			</table>
	</form>
	
	
</div>






