<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<style>

.title{
font-size: X-large;
}

.ll {
list-style:none;
font-family: center;
}


.ll li{
display:block; width:14%; height:40px; color:#fff; border:1px black; font-size:12px; font-family:"돋움";
 text-align:center; padding-top:10px; text-decoration:none; float:left; list-style:none; margin: 1; font-size: large;
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
height :100px;
 background-color: white; 
 width:100%;
 border-top: 3px solid #503396 ;
}

.a1{

}
 </style>

<script type="text/javascript">
function eventUpdate() {
	var q = "ecode=${dto.ecode}&page=${page}";
	var url = "<%=cp%>/event/update?" + q;
	
	if(confirm("이벤트를 수정 하시겠습니까?")) {
		location.href=url;
	}
}

function eventDelete() {
	var q = "ecode=${dto.ecode}&${query}";
	var url = "<%=cp%>/event/delete?" + q;
	
	if(confirm("이벤트를 삭제 하시겠습니까?")) {
		location.href=url;
	}
}

function login() {
	location.href="<%=cp%>/member/login";
}

function ajaxJSON(url, type, query, fn) {
	$.ajax({
		type:type
		,url:url
		,data:query
		,dataType:"json"
		,success:function(data) {
			fn(data);
		}
		,beforeSend:function(jqXHR) {
	        jqXHR.setRequestHeader("AJAX", true);
	    }
	    ,error:function(jqXHR) {
	    	if(jqXHR.status==403) {
	    		login();
	    		return false;
	    	}
	    	console.log(jqXHR.responseText);
	    }
	});
}


function ajaxHTML(url, type, query, selector) {
	$.ajax({
		type:type
		,url:url
		,data:query
		,success:function(data) {
			$(selector).html(data);
		}
		,beforeSend:function(jqXHR) {
	        jqXHR.setRequestHeader("AJAX", true);
	    }
	    ,error:function(jqXHR) {
	    	if(jqXHR.status==403) {
	    		login();
	    		return false;
	    	}
	    	console.log(jqXHR.responseText);
	    }
	});
}

</script>

 
 <div class="center">
	<div style="width: 60%;margin: 10px auto;">
    <ul class="ll" > 
        <li><a href="<%=cp%>/event/list?ecategoryCode=0">전체</a></li>
        <li><a href="<%=cp%>/event/list?ecategoryCode=1">메가박수진이벤트</a></li>
        <li><a href="<%=cp%>/event/list?ecategoryCode=2">영화 이벤트</a></li>   
        <li><a href="<%=cp%>/event/list?ecategoryCode=3">제휴 이벤트</a></li>
        <li><a href="<%=cp%>/event/list?ecategoryCode=4">영화관이벤트</a></li>
        <li><a href="<%=cp%>/roto/listDott">당첨자발표</a></li>
        <li><a href="<%=cp%>">현황 통계</a></li>
    </ul>
    </div>
</div>
 
<div class="body-container" style="width: 900px;">
    <div class="body-title">
        <h3><i class="far fa-image"></i> ${dto.subject} </h3>
    </div>

    <div>
    	<table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;">
    		<tr >
        		<td width="40%" align="left" style="padding-left: 10px;">
			    	 이벤트 기간 : ${dto.sdate} ~ ${dto.edate}
			    	 ${dto.censor==1 ? "| 삭제된 이벤트":"" }
				</td>
				<td width="40%" align="right" style="padding-right: 10px;">
				<c:if test="${dto.lott == 1}">
			    	당첨자 발표 : ${dto.lottDate}
				</c:if>
				</td>
				
			</tr>
    	</table>
    	
    </div>
    
    <div style="width: 100%; margin: 10px auto 0px; text-align: center;">
        <div style="border-bottom: 2px solid #cccccc;">
    	   <a href="${dto.elink}">
    		<img src="http://localhost:9090/mgbxAD/uploads/event/${dto.imageFilename}" width="70%" style="margin: 0px 10px;">
    	   </a>
        </div>
        
    	<table style="width: 100%; margin: 0px auto 20px; border-spacing: 0px; ">
			<tr height="45">
			    <td align="right">			    
			          <button type="button" class="btn" onclick="eventUpdate();">수정</button>			    
			          <button type="button" class="btn" onclick="eventDelete();">삭제</button>
			          <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/event/list?${query}';">리스트</button>
			    </td>
			</tr>
			</table>
    </div>
	</div>


</div>