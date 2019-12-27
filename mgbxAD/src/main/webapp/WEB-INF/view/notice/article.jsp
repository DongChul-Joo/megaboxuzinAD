<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<script type="text/javascript">
function deleteNotice() {
	<c:if test="${sessionScope.member.adminId=='admin'}">
		var q = "code=${dto.code}&${query}";
		var url = "<%=cp%>/notice/delete?" + q;
		
		if(confirm("해당 글을 삭제하시겠습니까?")) {
			location.href=url;
		}
	</c:if>

	<c:if test="${sessionScope.member.adminId!='admin'}">
		alert("해당 글을 삭제할 수 없습니다.");
	</c:if>
}

function updateNotice() {
	<c:if test="${sessionScope.member.adminId=='admin'}">
		var q = "code=${dto.code}&page=${page}";
		var url = "<%=cp%>/notice/update?" + q;
		location.href=url;
	</c:if>
	
	<c:if test="${sessionScope.member.adminId!='admin'}">
		alert("해당 글을 수정할 수 없습니다.");
	</c:if>	
}

</script>

<div class="body-container" style="width: 700px;">
	<div class="body-title">
		<h3><span style="font-family: Webdings">2</span> 공지사항 </h3>
	</div>

    <div>
			<table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;">
			<tr height="35" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;">
			    <td colspan="2" align="center">
				   ${dto.subject}
			    </td>
			</tr>
			
			<tr height="35" style="border-bottom: 1px solid #cccccc;">
			    <td width="50%" align="left" style="padding-left: 5px;">
			       아이디 : ${dto.userId}
			    </td>
			    <td width="50%" align="right" style="padding-right: 5px;">
			        ${dto.created}
			    </td>
			</tr>
			
			<tr style="border-bottom: 1px solid #cccccc;">
			  <td colspan="2" align="left" style="padding: 10px 5px;" valign="top" height="200">
			      ${dto.content}
			   </td>
			</tr>
			
			<c:forEach var="vo" items="${listFile}">
				<tr height="35" style="border-bottom: 1px solid #cccccc;">
				    <td colspan="2" align="left" style="padding-left: 5px;">
				      <a href="<%=cp%>/notice/download?fileNum=${vo.fileNum}">${vo.originalFilename}</a>
			          <%-- (<fmt:formatNumber value="${vo.fileSize/1024}" pattern="0.00"/> KByte) --%>
				    </td>
				</tr>
			</c:forEach>
			
			<tr height="35" style="border-bottom: 1px solid #cccccc;">
			    <td colspan="2" align="left" style="padding-left: 5px;">
			       이전글 :
			         <c:if test="${not empty preReadDto}">
			              <a href="<%=cp%>/notice/article?${query}&code=${preReadDto.code}">${preReadDto.subject}</a>
			        </c:if>
			    </td>
			</tr>
			
			<tr height="35" style="border-bottom: 1px solid #cccccc;">
			    <td colspan="2" align="left" style="padding-left: 5px;">
			       다음글 :
			         <c:if test="${not empty nextReadDto}">
			              <a href="<%=cp%>/notice/article?${query}&code=${nextReadDto.code}">${nextReadDto.subject}</a>
			        </c:if>
			    </td>
			</tr>
			</table>
			
			<table style="width: 100%; margin: 0px auto 20px; border-spacing: 0px;">
			<tr height="45">
			    <td width="300" align="left">
		          <button type="button" class="btn" onclick="updateNotice();" ${sessionScope.member.adminId!="admin" ? "style='pointer-events:none;'":"" }>수정</button>
		          <button type="button" class="btn" onclick="deleteNotice();" ${sessionScope.member.adminId!="admin" ? "style='pointer-events:none;'":"" }>삭제</button>
			    </td>
			
			    <td align="right">
			        <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/notice/list?${query}';">리스트</button>
			    </td>
			</tr>
			</table>
    </div>
    
</div>