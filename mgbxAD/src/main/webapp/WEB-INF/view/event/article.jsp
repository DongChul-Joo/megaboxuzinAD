<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>





<style>
.ll {
list-style:none;
margin:0px auto; width: 1000px;
}



.ll li{
display:block; width:130px; height:40px; background:tomato; color:#fff; border:1px black; font-size:12px; font-family:"돋움";
 text-align:center; padding-top:10px; text-decoration:none; float:left; list-style:none; margin: 1;
 }
 
.lo {
list-style:none;
float: left; 
}

.lo li{
list-style:none;
float: left;
}


.*{
font-family: 'Sunflower', sans-serif;

}

.center {
text-align: center;
}

.a1{

}
 </style>

 
 <div class="body-container" style="width: 1200px;">

<div style="width:100% ;height:100px; background: purple;">
공백
</div>


<div style="width: 100%; height:100px; background-color: white; ">
    <ul class="ll" > 
        <li><a href="<%=cp%>">전체</a></li>
        <li><a href="<%=cp%>">메가박수진이벤트</a></li>
        <li><a href="<%=cp%>">영화 이벤트</a></li>   
        <li><a href="<%=cp%>">제휴 이벤트</a></li>
        <li><a href="<%=cp%>">영화관이벤트</a></li>
        <li><a href="<%=cp%>">당첨자발표</a></li>
        <li><a href="<%=cp%>">현황 통계</a></li>
    </ul>
</div>

<div class="body-container" style="width: 700px;">
    <div class="body-title">
        <h3><i class="far fa-image"></i> 이벤트 이름 </h3>
    </div>
    
    <div>
    	<table>
    		<tr style="width: 100%; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;">
        		<td width="40%" align="left" style="padding-right: 10px; border-spacing: 0px; border-collapse: collapse;">
			    	 이벤트 기간 : ${dto.sdate} ~ ${dto.edate}
				</td>
				
				<td width="40%" align="right" style="padding-right: 10px; border-spacing: 0px; border-collapse: collapse;">
			    	 당첨자 발표 : 당첨자 발표 날짜
				</td>
			</tr>
    	</table>
    	
    </div>
    <div style="width: 80%; margin: 10px auto 0px; text-align: center;">
    	<a href="${dto.elink}">
    		<img src="<%=cp%>/uploads/event/${dto.imageFilename}" width="70%" style="margin: 0px 10px;">
    	</a>

    	
    	<table style="width: 100%; margin: 0px auto 20px; border-spacing: 0px; ">
			<tr height="45">
			    <td width="300" align="right">			    
			          <button type="button" class="btn" onclick="eventupdate('${dto.ecode}');">수정</button>			    
			          <button type="button" class="btn" onclick="eventdelete('${dto.ecode}');">삭제</button>
			    </td>
			</tr>
			</table>
    	
    </div>
</div>



</div>