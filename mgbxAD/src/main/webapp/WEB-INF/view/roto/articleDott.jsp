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

<script type="text/javascript">

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

 
 <div class="body-container" style="width: 1200px;">

<div style="width:100% ;height:100px; background: purple;">
공백
</div>


<div style="width: 100%; height:100px; background-color: white; ">
    <ul class="ll" > 
        <li><a href="<%=cp%>/event/list?ecategoryCode=0">전체</a></li>
        <li><a href="<%=cp%>/event/list?ecategoryCode=1">메가박수진이벤트</a></li>
        <li><a href="<%=cp%>/event/list?ecategoryCode=2">영화 이벤트</a></li>   
        <li><a href="<%=cp%>/event/list?ecategoryCode=3">제휴 이벤트</a></li>
        <li><a href="<%=cp%>/event/list?ecategoryCode=4">영화관이벤트</a></li>
        <li><a href="<%=cp%>">당첨자발표</a></li>
        <li><a href="<%=cp%>">현황 통계</a></li>
    </ul>
</div>

<div class="body-container" style="width: 700px;">
    <div class="body-title">
        <h3><i class="far fa-image"></i> ${dto.subject} </h3>
    </div>
    
    <div>
    	<table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;">
    	
    		<tr height="30">
        		<td align="left" style="padding-left: 10px;">
			    	 ${dto.pubDate}
				</td>
				
			</tr>
    		<tr height="50">
        		<td align="left" style="padding-right: 10px; border-spacing: 0px; border-collapse: collapse;">
			    	 ${dto.content}
				</td>
				
			</tr>
    	</table>
    	
    </div>
    
    <div style="width: 100%; margin: 10px auto 0px; text-align: center;">
        <div style="border-bottom: 2px solid #cccccc;">

        </div>
        
        <c:if test="${listPic.size()!=0}">
        <div>
    	<table style="width: 100%; margin: 10px auto 0px; border-spacing: 0px; border-collapse: collapse;">
    		<caption style="height:35px;"><span style="font-weight: 700; font-size: 16px;">이벤트 당첨자 명단</span></caption>
			<tr height="35" align="center" style="border-top: 1px solid #cccccc;border-bottom: 1px solid #cccccc;">
			    <th>아이디</th>
			    <th>이름</th>
			    <th>전화번호</th>
			    <th>이메일</th>
			</tr>
			
			<c:forEach var="vo" items="${listPic}">
				<tr height="35" align="center" style="border-bottom: 1px solid #cccccc;">
				    <td>${vo.userId}</td>
				    <td>${vo.userName}</td>
				    <td>${vo.tel}</td>
				    <td>${vo.email}</td>
				</tr>
			</c:forEach>
		</table>
        </div>
        </c:if>
        
    	<table style="width: 100%; margin: 0px auto 20px; border-spacing: 0px; ">
			<tr height="45">
			    <td align="right">			    
			          <button type="button" class="btn" onclick="eventUpdate();">수정</button>			    
			          <button type="button" class="btn" onclick="eventDelete();">삭제</button>
			          <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/roto/listDott?${query}';">리스트</button>
			    </td>
			</tr>
			</table>
    </div>
	</div>

</div>