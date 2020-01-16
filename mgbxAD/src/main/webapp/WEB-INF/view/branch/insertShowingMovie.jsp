<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<script type="text/javascript">

function selectCinema(cmCode){
 	
}

</script>



<div style="width: 1000px; min-height: 500px; margin: 0px auto;">
	<c:forEach var="vo" items="${list}">
		<div style="width:200px; height: 250px; float: left; margin: 0px auto;">
			<img src="${vo.thumbNail}" style="width: 130px; height: 150px;">
			<p>${vo.movieNm}</p>
			<button type="button" onclick="insertMovie('${vo.movieCode}')">등록</button>
		</div>
	</c:forEach>
</div>


<br>
<br>


        


