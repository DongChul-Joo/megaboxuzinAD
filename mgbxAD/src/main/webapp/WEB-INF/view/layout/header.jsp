<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>



<div class="header-top">
    <div class="header-left">
        <p style="margin: 2px;">
            <a href="<%=cp%>/" style="text-decoration: none;">
                <span style="padding-left:60px;width: 200px; height: 70; position: relative; left: 0; top:20px; color: black; filter: mask(color=red) shadow(direction=135) chroma(color=red);font-style: italic; font-family: arial black; font-size: 30px; font-weight: bold;">MegaboxuZin</span>
            </a>
        </p>
    </div>
    
    
    <div class="header-right">
        <div style="padding-top: 20px;  float: right; padding-right: 120px;">
            <c:if test="${empty sessionScope.member}">
                <a href="<%=cp%>/member/login">로그인</a>
                    &nbsp;|&nbsp;
                
            </c:if>
            <c:if test="${not empty sessionScope.member}">
                <span style="color:blue;">${sessionScope.member.adminId}</span>님
                &nbsp;|&nbsp;
                <a href="<%=cp%>/member/logout">로그아웃</a>
            </c:if>
        </div>
    </div>
</div>




<div class="menu" style="width: 100%; background-color: white; ">
 <c:if test="${member.adminId=='mainAdmin'}">
    <ul class="nav" style=" margin:0px auto ; width: 1200px;"> 
    	<!--<li><img src="<%=cp%>/resource/images/susu.jpg" style="float: left;"></li>-->
        <li><a href="<%=cp%>/movie/movie">영화관리</a></li>
        <li><a href="<%=cp%>/branch/branch">지점관리</a></li>
        <li><a href="<%=cp%>/sales/sales">매출관리</a></li>   
        <li><a href="<%=cp%>/event/list">이벤트 관리</a></li>
        <li><a href="<%=cp%>/item/list">스토어 관리</a></li>
        <li><a href="<%=cp%>/question/list">고객관리</a></li>
       			 <!-- 1:1문의처리  쿠폰 멤버십-->
        <li><a href="<%=cp%>/etc/etc">현황 통계</a></li>

    </ul>
</c:if>

<c:if test="${member.adminId=='admin'}">
    <ul class="nav" style=" margin:0px auto; width: 1200px;"> 
        <li><a href="<%=cp%>/movie/movie">영화관리</a></li>
        <li><a href="<%=cp%>/branch/branch">지점관리</a></li>
        <li><a href="<%=cp%>/">매출관리</a></li>   
        <li><a href="<%=cp%>/event/list">이벤트 관리</a></li>
        <li><a href="<%=cp%>/item/list">스토어 관리</a></li>
        <li><a href="<%=cp%>/">고객관리</a></li>
        <li><a href="<%=cp%>/question/list">1:1 문의</a></li>
    </ul>
    
    
</c:if>

 <c:if test="${member.adminId=='subAdmin'}">
    <ul class="nav" style=" margin:0px auto; width: 1200px;"> 
    	<!--<li><img src="<%=cp%>/resource/images/susu.jpg" style="float: left;"></li>-->
        <li><a style="border: 1px solid #e7e7e7;" href="<%=cp%>/branchmovie/branchmovie">상영영화 관리</a></li>
        <li><a style="border: 1px solid #e7e7e7;" href="<%=cp%>/branchschedule/branchschedule">시간표 관리</a></li>
        <li><a style="border: 1px solid #e7e7e7;" href="<%=cp%>/brancreate/branchcreate">영화관 관리</a></li>
        <li><a style="border: 1px solid #e7e7e7;" href="<%=cp%>/branetc/branchetc">현황 관리</a></li>
        <li><a style="border: 1px solid #e7e7e7;" href="<%=cp%>/bransales/branchsales">매출 관리</a></li>
        <li><a style="border: 1px solid #e7e7e7;" href="<%=cp%>/branEmp/branchemp">직원 관리</a></li>

    </ul>
</c:if>



</div>


