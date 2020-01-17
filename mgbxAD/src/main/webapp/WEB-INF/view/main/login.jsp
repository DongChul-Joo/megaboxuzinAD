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
<style type="text/css">

.dv{
margin:0px auto;
height: 1000px;
width: 500px;
padding-top: 227px;
}

.in{
width: 300px;
height: 50px;
font-size: 20px;
font-weight: bold;
margin:0px auto;
color: white;

}

.in input{
	width: 300px;
	height: 40px;
	border-radius: 5px;
	
}


.dv2 {
width: 500px;
height: 500px;
background-color: rgba(51, 44, 44, 0.9);
}

#loginForm{
padding-top: 20px;
}

.mainLog{
padding-bottom: 5px;
}

.mainLogButton{
width: 140px;
background-color:  rgba(51, 44, 44, 0.5);
border: 1px solid white;
height: 50px;
color: white;
padding-left: 10px;
border-radius: 5px;
}

.mainLog2{
float: left;
}

.fullfooter {
width: 297px;
margin: 0 auto;
padding-top: 20px;
}


</style>
<title>Insert title here</title>

<script type="text/javascript">


function sendLogin() {
	
    var f = document.loginForm;

	var str = f.adminId.value;
    if(!str) {
        alert("아이디를 입력하세요. ");
        f.adminId.focus();
        return;
    }

    str = f.adminPwd.value;
    if(!str) {
        alert("패스워드를 입력하세요. ");
        f.adminPwd.focus();
        return;
    }

    f.action = "<%=cp%>/member/login";
    f.submit();
}
</script>
</head>
<body style="margin: 0px;">  
<div style="width: 100%;height:100%; background:rgba(51, 44, 44, 0.9);">
<div class="dv">

<div class="dv2">
		<form id="loginForm" name="loginForm" method="post">
		<p align="center" style="font-size: 50px; font-weight: bold;padding-top: 13px; color: white;">LogIN</p>
		<div class="mainLog">
		<p  class="in"><input type="text" id="adminId" name="adminId" placeholder="아이디"></p>
		</div>
		<div class="mainLog">
		<p  class="in"><input type="password" id="adminPwd" name="adminPwd" placeholder="비밀번호"></p>
		</div>
		
		
		<div class="fullfooter">
			<div class="mainLog2">
				<p style="margin:0px auto;">
				
				<button class="mainLogButton" type="button" onclick="sendLogin();" style="font-size: 20px;font-weight: bold;margin-right: 17px;">로그인</button></p>
			</div>
		
			<div class="mainLog2">
			<button class="mainLogButton" style="font-size: 20px;font-weight: bold;">가입</button>
			</div>
			
		</div>
			
		</form>
</div>


</div>
</div>
</body>
</html>