<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>


<script type="text/javascript">
function send() {
	var f = document.winnerForm;
	
	f.action="<%=cp%>/roto/${mode}";
	f.submit();
}
</script>

<div class="center">
	<div style="width: 60%;margin: 10px auto;">
    <ul class="ll" > 
        <li><a href="<%=cp%>/event/list?ecategoryCode=0">전체</a></li>
        <li><a href="<%=cp%>/event/list?ecategoryCode=1">메가박수진이벤트</a></li>
        <li><a href="<%=cp%>/event/list?ecategoryCode=2">영화 이벤트</a></li>   
        <li><a href="<%=cp%>/event/list?ecategoryCode=3">제휴 이벤트</a></li>
        <li><a href="<%=cp%>/event/list?ecategoryCode=4">영화관이벤트</a></li>
        <li><a href="<%=cp%>/roto/listDott">당첨자발표</a></li>
        <li><a href="<%=cp%>">현황 통계</a></li>
    </ul>
    </div>
</div>
 
<div class="body-container" style="width: 1000px;">
    <div class="body-title">
        <h3><i class="fas fa-chalkboard"></i> 당첨자 발표 </h3>
    </div>
    
    <div>    
			<form name="winnerForm" method="post"  enctype="multipart/form-data">
			  <table style="width: 115%; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;">
			  <tbody id="boardBody">
			  <tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
			      <td width="100" bgcolor="#eeeeee" style="text-align: center;">제&nbsp;&nbsp;&nbsp;&nbsp;목</td>
			      <td style="padding-left:10px;"> 
			        <input type="text" name="subject" maxlength="100" class="boxTF" style="width: 95%;" value="${dto.subject}">
			      </td>
			  </tr>
			  
			  <tr align="left" style="border-bottom: 1px solid #cccccc;"> 
				<td width="100" bgcolor="#eeeeee" style="text-align: center; padding-top:5px;" valign="top">내&nbsp;&nbsp;&nbsp;&nbsp;용</td>
					<td valign="top" style="padding:5px 0px 5px 10px;"> 
						<textarea name="content" id="content" class="boxTA" style="width:95%; resize: none; height: 270px;">${dto.content}</textarea>
			</td>
			  
			  </tbody>
			  </table>
			
			  <table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
			     <tr height="45"> 
			      <td align="center" style="padding-bottom: 20px">
			        <button type="button" class="btn" onclick="send();">${mode=='update'?'수정완료':'당첨완료'}</button>
					<button type="button" class="btn">다시입력</button>
					<button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/roto/listDott?page=${page}';">${mode=='update'?'수정취소':'당첨취소'}</button>
					<input type="hidden" name="ecode" value="${dto.ecode}">
					<input type="hidden" name="page" value="${page}">
			      </td>
			    </tr>
			  </table>
			</form>
    </div>
 
</div>