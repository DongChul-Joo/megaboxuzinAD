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
width: 1000px;
}

.in{
width: 300px;
height: 50px;
font-size: 20px;
font-weight: bold;
margin:0px auto;
}

.in input{
	width: 200px;
	height: 25px;
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
<body>  
<div style="width: 100%;height:1000px; background: linear-gradient(to top, #2b2e40, #846f9a);">
<div class="dv">
<form id="loginForm" name="loginForm" method="post">
<p align="center" style="font-size: 50px; font-weight: bold;padding-top: 50px;">LogIN</p>
<p  class="in">ID : <input type="text" id="adminId" name="adminId"></p>
<p  class="in">PWD : <input type="password" id="adminPwd" name="adminPwd"></p>
<p style="width:200px ;margin:0px auto;"><button type="button" onclick="sendLogin();" style="font-size: 20px;font-weight: bold;">로그인</button>
<button style="font-size: 20px;font-weight: bold;">가입</button></p>
</form>
</div>
</div>
</body>
</html>