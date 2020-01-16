<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<style>

.footerfon {
	color: white;
}

.fn {
width: 1200px;
margin: 0 auto 14px;
line-height: 200%;
text-align: left;
}

.fn2{
float: left;
width: 698px;

}

.fn3{
width:502px;
float: left;
text-align: right;

}

.image1 {
list-style: none;
}

.image2{
float: left;
width: 100px;
text-align: center;
padding-bottom: 15px;
margin-right: 50px;
margin-bottom: 5px;
margin-right: 17px;

}

.image1 li:nth-child(1) {
background-image: url("<%=cp%>/resource/images/twitter.png");
background-size: cover;
width: 65px;
height: 50px;

}

.image1 li:nth-child(2) {
background-image: url("<%=cp%>/resource/images/instagram.png");
background-size: cover;
width: 65px;
height: 50px;

}


.image1 li:nth-child(3) {
background-image: url("<%=cp%>/resource/images/apple.png");
background-size: cover;
width: 65px;
height: 50px;

}

.image1 li:nth-child(4) {
background-image: url("<%=cp%>/resource/images/android.png");
background-size: cover;
width: 65px;
height: 50px;
}

</style>

<div class="footerfon fn fn1">
	<img src="<%=cp%>/resource/images/logogo.png" width="150px;" height="50px" >
</div>

<div class="footerfon fn">
<a class="footerfon" href="">SPRING 정책 및 약관</a>&nbsp;&nbsp;&nbsp;
<a class="footerfon" href="">회사소개</a>&nbsp;&nbsp;&nbsp;
<a class="footerfon" href="">제휴제안</a>&nbsp;&nbsp;&nbsp;
<a class="footerfon" href="">이용약관</a>&nbsp;&nbsp;&nbsp;
<a class="footerfon" href="">개인정보취급방침</a>&nbsp;&nbsp;&nbsp;
<a class="footerfon" href="">고객센터</a>&nbsp;&nbsp;&nbsp;
<a class="footerfon">© SPRING Corp.</a>
</div>


<div class="footerfon fn">
<div class="fn2">서울특별시 마포구 왕십리로 50, 6층(홍대 1가, 쌍용교육센터)<br>
대표자명 김진선 | 개인정보보호 책임자 BP본부 본부장 주동철<br>
사업자등록번호 211-86-12345 | 통신판매업신고번호 제 777호</div>



<div class="fn3">
	<div>
	<ul class="image1">
		<li class="image2" style="margin-left: 169px;"><a></a></li>
		<li class="image2"><a></a></li>
		<li class="image2"><a></a></li>
		<li class="image2"><a></a></li>
		<li>Copyright 2020 by Megaboxuzin, Inc. All rights reserved</li>
	</ul>
	</div>
	
	
</div>


</div>

