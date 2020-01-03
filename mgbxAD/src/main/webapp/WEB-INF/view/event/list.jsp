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
function article(ecode) {
	var url="${articleUrl}&ecode="+ecode;  
	location.href=url;
}
</script>

<div class="body-container" style="width: 1200px;">

<div style="width:100% ;height:100px; background: purple;">
</div>

<div style="width: 100%; height:100px; background-color: white; ">
    <ul class="ll" > 
        <li><a href="<%=cp%>/event/list?ecategoryCode=0">전체</a></li>
        <li><a href="<%=cp%>/event/list?ecategoryCode=1">메가박수진이벤트</a></li>
        <li><a href="<%=cp%>/event/list?ecategoryCode=2">영화 이벤트</a></li>   
        <li><a href="<%=cp%>/event/list?ecategoryCode=3">제휴 이벤트</a></li>
        <li><a href="<%=cp%>/event/list?ecategoryCode=4">영화관이벤트</a></li>
        <li><a href="<%=cp%>/event/listDott">당첨자발표</a></li>
        <li><a href="<%=cp%>">현황 통계</a></li>
    </ul>
</div>

<div style="width: 100%; height: 5%;">
	<ul class="lo">
		<li><a href="<%=cp%>/event/list?state=1&ecategoryCode=${ecategoryCode}">진행중 이벤트 | </a></li>
		<li><a href="<%=cp%>/event/list?state=0&ecategoryCode=${ecategoryCode}">종료된 이벤트</a></li>
	</ul>
	<div style="width: 40%; height: 5%; float: right; margin: 10px;">
		<input type="text" title="검색어 입력" placeholder="검색어를 입력하세요">
		<button type="submit" onclick="">이미지</button>
	</div>
</div>
<table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
<c:forEach var="dto" items="${list}" varStatus="status">
	<c:if test="${dtatus.index==0}">
		<tr>
	</c:if>
	<c:if test="${status.index!=0 && status.index%3==0}">
    	<c:out value="</tr><tr>" escapeXml="false"/>
    </c:if>
	<td width="210" align="center">
		<div class="imglayout">
			<img src="<%=cp%>/uploads/event/${dto.imageFilename}" width="180"
				height="180" border="0" onclick="article('${dto.ecode}');">
			<span class="subject" onclick="javascript:article('${dto.ecode}');" ><br>
				${dto.subject}<br>
				${dto.sdate} ~ ${dto.edate}
			</span>
			
		</div>
	</td>     
</c:forEach>
	<c:set var="n" value="${list.size()}"/>
	<c:if test="${n>0&&n%3!=0}">
		        <c:forEach var="i" begin="${n%3+1}" end="3" step="1">
			         <td width="210">
			             <div class="imgLayout">&nbsp;</div>
			         </td>
		        </c:forEach>
	</c:if>
	
	<c:if test="${n!=0}">
		       <c:out value="</tr>" escapeXml="false"/>
	</c:if>
		</table>           
		 
		<table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
		   <tr height="35">
			<td align="center">
			    ${dataCount==0?"등록된 게시물이 없습니다.":paging}
			 </td>
		   </tr>
		</table>

	<div style="float: right;">
		<button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/event/created';">등록하기</button> 
	</div>
</div>
