<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<style type="text/css">
.imgLayout{
	width: 190px;
	height: 205px;
	padding: 10px 5px 10px;
	margin: 5px;
	cursor: pointer;
}
.itemName {
     width:180px;
     height:25px;
     line-height:25px;
     margin:5px auto;
     border-top: 1px solid #DAD9FF;
     display: inline-block;
     white-space:nowrap;
     overflow:hidden;
     text-overflow:ellipsis;
     cursor: pointer;
}
</style>

<script type="text/javascript">
function searchList() {
	var f=document.searchForm;
	f.submit();
}

function article(itemCode) {
	var url="${articleUrl}&itemCode="+itemCode;
	location.href=url;
}
</script>

<div class="body-container" style="width: 840px;">
	<div class="body-title">
		<h3>| 상품</h3>
		<button type="button" onclick="javascript:location.href='<%=cp%>/item/created';"> 상품등록</button>
	</div>
	
	<div>
		
		<table style="width: 100%; margin: 0px auto; border-spacing: 0px; border-collapse: collapse;">
			<c:set var="cnt" value="0"/>
			<c:set var="itemPart" value=""/>
			
			<c:forEach var="dto" items="${list}" varStatus="status">
				<c:if test="${cnt!=0 && cnt%4==0}">
				    <c:set var="cnt" value="0"/>
					<c:out value="</tr><tr>" escapeXml="false"/>
				</c:if>
				
				<c:if test="${cnt!=0 && itemPart != dto.itemPart}">
					<c:forEach var="i" begin="${cnt%4+1}" end="4" step="1">
					   <td width="210">
						   <div class="imgLayout">&nbsp;</div>
					   </td>
				    </c:forEach>
				    <c:out value="</tr>" escapeXml="false"/>
				</c:if>

				<c:if test="${cnt==0 || itemPart != dto.itemPart}">
					<c:set var="cnt" value="0"/>
					<c:set var="itemPart" value="${dto.itemPart}"/>
					<tr height="5">
					  <td colspan="4" align="left">&nbsp;</td>
					</tr>
					
					<tr height="35">
					  <td colspan="4" align="left">${dto.itemPart}</td>
					</tr>
					<tr>
				</c:if>
				
				<c:set var="cnt" value="${cnt+1}"/>
				<td width="210" align="center">
					<div class="imgLayout">
						<img src="<%=cp%>/uploads/item/${dto.itemImg}" width="180" 
							height="180" border="0" onclick="javascript:article('${dto.itemCode}');">
						<span class="itemName" onclick="javascript:article('${dto.itemCode}')">
							${dto.itemName}
						</span>
					</div>
				</td>	
			</c:forEach>
			
			<c:if test="${cnt!=0}">
			    <c:forEach var="i" begin="${cnt%4+1}" end="4" step="1">
			       <td width="210">
					  <div class="imgLayout">&nbsp;</div>
					</td>
				</c:forEach>
				<c:out value="</tr>" escapeXml="false"/>
			</c:if>	
		</table>
		
		<table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
			<tr height="30">
				<td align="center">
					${dataCount==0?"등록된 게시물이 없습니다.":""}
				</td>
			</tr>		
		</table>
	
	</div>
	
</div>