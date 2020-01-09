<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>


<style>
.question {
background-color: #731070;
color: white;
}

</style>

<form name="boardForm" method="post" enctype="multipart/form-data">
  <table style="width: 100%; margin: 50px auto 0px; border-spacing: 0px; border-collapse: collapse;">
  <tbody id="tb">

  <tr align="left" height="60" style="border-top: 1px solid #731070; border-bottom: 1px solid #cccccc;"> 
      <td class="question" width="100" bgcolor="#eeeeee" style="text-align: center;">작성자</td>
      <td style="padding-left:10px;"> 
          ${sessionScope.member.userName}
      </td>
  </tr>
  
  
  <tr align="left" height="60" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
      <td class="question" width="100" bgcolor="#eeeeee" style="text-align: center;">구&nbsp;&nbsp;&nbsp;&nbsp;분</td>
      <td style="padding-left:10px;"> 
           <select name="cateCode" class="selectField">
               <option value="">::분류선택::</option>
	               <c:forEach var="vo" items="${list}">
	               		<option value="${vo.cateCode}">${vo.cateName}</option>
	               </c:forEach>
           </select>
      </td>
  </tr>

  <tr align="left" height="60" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
      <td class="question" width="100" bgcolor="#eeeeee" style="text-align: center;">제&nbsp;&nbsp;&nbsp;&nbsp;목</td>
      <td style="padding-left:10px;"> 
        <input type="text" name="subject" maxlength="100" class="boxTF" style="width: 95%;" value="${dto.subject}">
      </td>
  </tr>

  <tr align="left" style="border-bottom: 1px solid #731070;"> 
      <td class="question" width="100" bgcolor="#eeeeee" style="text-align: center; padding-top:5px;" valign="top">내&nbsp;&nbsp;&nbsp;&nbsp;용</td>
      <td valign="top" style="padding:5px 0px 5px 10px;"> 
        <textarea name="content" rows="15" class="boxTA" style="width: 95%;">${dto.content}</textarea>
      </td>
  </tr>
  </tbody>

  </table>

  <table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
     <tr height="45"> 
      <td align="center" style="padding-top: 20px;">
        <button type="button" class="btn" onclick="sendOk('${mode}', '${pageNo}');">${mode=='update'?'수정완료':'등록하기'}</button>
        <button type="reset" class="btn">다시입력</button>
        <button type="button" class="btn" onclick="sendCancel('${pageNo}');">${mode=='update'?'수정취소':'등록취소'}</button>
         <c:if test="${mode=='update'}">
         	 <input type="hidden" name="code" value="${dto.code}">
        	 <input type="hidden" name="pageNo" value="${pageNo}">
        </c:if>
         <c:if test="${mode=='reply' || mode=='question'}">
         	 <input type="hidden" name="parent" value="${dto.code}">
        	 <input type="hidden" name="pageNo" value="${pageNo}">
        </c:if>
      </td>
    </tr>
  </table>
</form>
