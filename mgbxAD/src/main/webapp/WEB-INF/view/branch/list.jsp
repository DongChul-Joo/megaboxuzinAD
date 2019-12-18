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
<title>Insert title here</title>
<style type="text/css">

</style>


<script type="text/javascript">


</script>
</head>
<body>
<div>
<button type="button" onclick="javascript:location.href='<%=cp%>/branch/created'">지점등록</button>
<button type="button" onclick="javascript:location.href='<%=cp%>/cinema/created'">관등록</button><button type="button" onclick="javascript:location.href='<%=cp%>/cinema/update'">관수정</button>
	
</div>

</body>
</html>