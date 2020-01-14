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

function articleDott(ecode) {
	var url="${articleDottUrl}&ecode="+ecode;  
	location.href=url;
}

function searchList() {
	var f=document.searchForm;
	f.submit();
}
</script>

<div class="center">
	<div style="width: 55%;margin: 10px auto;">
    <ul class="ll" > 
        <li><a href="<%=cp%>/event/list?ecategoryCode=0">전체</a></li>
        <li><a href="<%=cp%>/event/list?ecategoryCode=1">메가박수진이벤트</a></li>
        <li><a href="<%=cp%>/event/list?ecategoryCode=2">영화 이벤트</a></li>   
        <li><a href="<%=cp%>/event/list?ecategoryCode=3">제휴 이벤트</a></li>
        <li><a href="<%=cp%>/event/list?ecategoryCode=4">영화관이벤트</a></li>
        <li><a href="<%=cp%>/roto/listDott">당첨자발표</a></li>
    </ul>
    </div>
</div>
 
<div class="body-container" style="width: 900px;">
    <div class="body-title">
        <h3><i class="fas fa-chalkboard"></i> 당첨자 발표 </h3>
    </div>
    
    <div>
		<table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px;">
		   <tr height="35">
		      <td align="left" width="50%">
		          ${dataCount}개(${page}/${total_page} 페이지)
		      </td>
		      <td align="right" width="50%">
		      <form name="searchForm" action="<%=cp%>/roto/listDott" method="post">
		              <select name="condition" class="selectField">
		                  <option value="all" ${condition=="all"?"selected='selected'":""}>전체</option>
		                  <option value="1" ${condition=="1"?"selected='selected'":""}>메가박수진이벤트</option>
		                  <option value="2" ${condition=="2"?"selected='selected'":""}>영화 이벤트</option>
		                  <option value="3" ${condition=="3"?"selected='selected'":""}>제휴 이벤트</option>
		                  <option value="4" ${condition=="4"?"selected='selected'":""}>영화관이벤트</option>
		            </select>
		          <input type="text" name="keyword" value="${keyword}" class="boxTF">
		          <button type="button" class="btn" onclick="searchList()">검색</button>
		        </form>
		       </td>
		      <td align="right">
		          &nbsp;
		      </td>
		   </tr>
		</table>
		
		<table style="width: 100%; margin: 0px auto; border-spacing: 0px; border-collapse: collapse;">
		  <tr align="center" bgcolor="#eeeeee" height="35" style="border-top: 2px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
		      <th width="15%" style="color: #787878;">분류</th>
		      <th width="35%" style="color: #787878;">제목</th>
		      <th width="25%" style="color: #787878;">이벤트 기간</th>
		      <th width="15%" style="color: #787878;">당첨일</th>
		      <th width="10%" style="color: #787878;">발표일</th>
		  </tr>
	<c:forEach var="dto" items="${list}">
		  <tr align="center" bgcolor="#ffffff" height="35" style="border-bottom: 1px solid #cccccc;"> 
		      <td>${dto.ecategoryName}</td>
		      <td><a href="${articleUrl}&ecode=${dto.ecode}">${dto.subject}</a></td>
		      <td>${dto.sdate} ~ ${dto.edate}</td>
		      <td>${dto.lottDate}</td>
		      <td>
		         <c:if test="${empty dto.pubDate}">
		             <button type="button" onclick="javascript:location.href='<%=cp%>/roto/winner?ecode=${dto.ecode}&page=${page}'">당첨자발표</button>
		         </c:if>
		         <c:if test="${not empty dto.pubDate}">
		            ${dto.pubDate}
		         </c:if>
		      </td>
		  </tr>
		  </c:forEach>


</table>
</div>


<table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
	<tr height="35">
		<td align="center">
		    ${dataCount==0?"등록된 게시물이 없습니다.":paging}
		</td>
	</tr>
</table>
</div>





