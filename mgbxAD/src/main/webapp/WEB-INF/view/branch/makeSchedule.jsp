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



<div style="width: 1000px; height: 500px; margin: 0px auto;">
	<c:forEach var="vo" items="${list}">
		<div style="width:250px;  float: left; margin: 0px auto;">
			<p><strong>${vo.cmName}관 관정보</strong></p>
			<p>상영 범위 : ${vo.cmRangeName} </p>
			<p>총 좌석수 : ${vo.cmSeatTot} 석</p>
			<button type="button" onclick="selectCinema('${vo.cmCode}')">${vo.cmName}관 선택</button>
		</div>
	</c:forEach>	
</div>


<br>
<br>


        


