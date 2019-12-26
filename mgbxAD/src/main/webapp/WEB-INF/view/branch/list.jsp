<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<style type="text/css">

.selectSeat{
width: 20px;
height: 20px;  
padding: 0;
text-align: center;
font-size: 10px;
font-weight:bold;   
background: white;
border: 1px solid black;  
}

.seatSelect{
width: 20px;
height: 20px;  
padding: 0;
text-align: center;
font-size: 10px;
font-weight:bold;   
background: white;
border: 1px solid black;  
}
.seatRows{
width: 22px;
height: 22px;  
padding: 0;
text-align: center;
font-size: 10px;
font-weight:bold;   
background: white;
border: 1px solid black;  
} 

.noneSeat{
width: 20px;
height: 20px;  
padding: 0;
text-align: center;
font-size: 9px;
font-weight:bold;   
background: purple;
border: 1px solid black;
color: white
}

.deleteSeat{
width: 20px;
height: 20px;   
pointer-events:none;
background: white;
border: none;
color: white;
}
.ui-button  {
    background: none;
	color:#333333;
	font-weight:500;
	border:1px solid #cccccc;
	background-color:#ffffff;
	text-align:center;
	cursor:pointer;
	padding:3px 10px 5px;
	border-radius:4px;
	font-family:"Malgun Gothic", "맑은 고딕", NanumGothic, 나눔고딕, 돋움, sans-serif;
}
</style>  

<div class="menu" style="background: white;border: none">
    <ul class="nav" style="margin:0px auto ; width: 1500px;">  
        <c:forEach var="vo" items="${areaList}">
        	<c:if test="${vo.areaCode==areaCode}">
        		 <li><a  style="width: 30px;line-height: 50px;color:white;background-color: #ca0909; border: none; " href="javascript:searchList('${vo.areaCode}','${page}');">${vo.areaName}</a></li>
			</c:if>
			<c:if test="${vo.areaCode!=areaCode}">
				 <li><a  style="width: 30px;line-height: 50px;color:white;background-color: #221f1f; border: none; " href="javascript:searchList('${vo.areaCode}','${page}');">${vo.areaName}</a></li>
			</c:if>
		</c:forEach>	
    </ul>
</div> 

 <c:forEach var="dto" items="${list}">
	<div style="width: 800px; height:150px;margin: 0px auto; margin-bottom: 20px;" >    
			
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
	<div>${paging}</div>
<div style="margin:0px auto;margin-left:500px; width: 200px; ">
	<button  class="btn" type="button" onclick="javascript:location.href='<%=cp%>/branch/created'">지점등록</button>
</div>
		<div id="map" style="display: none;width: 1000px;">
		</div>
		<div id="viewCinemas" style="display: none;width: 1000px;">
		</div>


