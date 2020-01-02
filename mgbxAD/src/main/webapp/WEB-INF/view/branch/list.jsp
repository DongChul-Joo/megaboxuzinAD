<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
 

 <c:forEach var="dto" items="${list}">
	<div style="width: 800px; height:150px;margin: 0px auto; margin-bottom: 10px;" >    
			
			<div style="width: 25%; height:100%; border:1px solid black ; 
			border-right:1px solid white; float: left" onclick="maps('${dto.branAddr1}','${dto.branName}');">
				<img src="<%=cp%>/branchImg/branch/${dto.imageFilename}" width="100%"
				height="100%" border="0" onclick="maps('${dto.branAddr1}','${dto.branName}');">
			</div>
			
			<div style="width: 60%;height:100%;float: left;border: 1px solid black" 
			onclick="maps('${dto.branAddr1}','${dto.branName}');">    
					<div style="width: 100%;height: 25%; border-bottom:  1px solid black">
						<p style="margin: 5px; margin-left: 38px; margin-top: 10px">지점명 : ${dto.branName}</p>
					</div>  
				  
					<div style="width: 100%;height: 70%;"> 
						<p style="margin: 5px; margin-left: 38px;margin-top: 20px;">우편번호 : ${dto.branZip}</p>
						<p style="margin: 5px; margin-top: 10px;margin-left: 38px;margin-top: 20px;">주소 : ${dto.branAddr1}&nbsp;${dto.branAddr2}</p>
					</div>
			</div> 
			<div style="width: 10%; float: left ;"  >
				<button class="btn" style="width: 65px; height:50px; border: 1px solid black;border-left:none; border-radius: 0; font-weight:bold;
					border-spacing: 0;border-collapse: collapse;" type="button" onclick="listCinema('${dto.branCode}','${dto.branName}')">관목록</button>
				<br>
				<button class="btn" style="width: 65px;height:51px; border: 1px solid black;border-top:none; border-left:none;  font-weight: bold;
					 border-radius: 0; border-spacing: 0;border-collapse: collapse;" type="button" onclick="javascript:location.href='<%=cp%>/branch/update?branCode=${dto.branCode}'">수정</button>
				<br>
				<button class="btn" style="width: 65px;height:51px; border: 1px solid black;border-top:none; border-left:none; font-weight: bold;
					 border-radius: 0; border-spacing: 0;border-collapse: collapse;" type="button" onclick="javascript:location.href='<%=cp%>/branch/delete?branCode=${dto.branCode}'">삭제</button>
			</div>
	</div>
	</c:forEach>
	
	<div>${dataCount==0?"등록된 게시물이 없습니다.":paging}</div>
	


