<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<style type="text/css">
  .questionQ{
    display: inline-block;
    padding:7px 10px;
	font-weight: bold;
	color: #ffffff;
	background: #731070;
	text-align: center;
  }
  .questionSubject{
    display: inline-block;
    position:absolute;
    width:1175px;
    overflow:hidden;
    text-overflow:ellipsis;
    word-spacing:nowrap;
    box-sizing:border-box;
    padding:7px 3px;
    margin-left:1px;
	font-weight: bold;
	color: #ffffff;
	background: #731070;
  }
  .answerA{
    display: inline-block;
    padding:7px 10px;
	font-weight: bold;
	color: #ffffff;
	background: #442e58;
	text-align: center;
  }
  .answerSubject{
    display: inline-block;
    position:absolute;
     width:1175px;
    overflow:hidden;
    text-overflow:ellipsis;
    word-spacing:nowrap;
    box-sizing:border-box;
    padding:7px 3px;
    margin-left:1px;
	font-weight: bold;
	color: #ffffff;
	background: #442e58;
  }
  
.container{
width: 63%;
margin: 0 auto;
}
  
  
</style>


<script type="text/javascript">
function login() {
	location.href="<%=cp%>/member/login";
}

function ajaxJSON(url, type, query, fn) {
	$.ajax({
		type:type
		,url:url
		,data:query
		,dataType:"json"
		,success:function(data) {
			fn(data);
		}
		,beforeSend:function(jqXHR) {
	        jqXHR.setRequestHeader("AJAX", true);
	    }
	    ,error:function(jqXHR) {
	    	if(jqXHR.status==403) {
	    		login();
	    		return false;
	    	}
	    	console.log(jqXHR.responseText);
	    }
	});
}

function ajaxHTML(url, type, query, selector) {
	$.ajax({
		type:type
		,url:url
		,data:query
		,success:function(data) {
			$(selector).html(data);
		}
		,beforeSend:function(jqXHR) {
	        jqXHR.setRequestHeader("AJAX", true);
	    }
	    ,error:function(jqXHR) {
	    	if(jqXHR.status==403) {
	    		login();
	    		return false;
	    	}
	    	console.log(jqXHR.responseText);
	    }
	});
}

//리플 등록
$(function(){
	$(".btnSendReply").click(function(){
		var code="${dto.code}";
		console.log(code);
		var $tb = $(this).closest("table");
		var content=$tb.find("textarea").val().trim();
		console.log(content);
		if(! content) {
			$tb.find("textarea").focus();
			return false;
		}
		content = encodeURIComponent(content);
		
		var url="<%=cp%>/question/reply";
		var query="code="+code+"&content="+content+"&isAnswer=0";
		
		var fn = function(data){
			$tb.find("textarea").val("");
			
			var isAnswer=data.isAnswer;
			if(isAnswer=="true") {
				listPage(1);
			} else if(isAnswer=="false") {
				alert("댓글을 추가 하지 못했습니다.");
			}
		};
		
		ajaxJSON(url, "post", query, fn);
	});
});

function deleteQuestion(code) {
	if(confirm("해당 글을 삭제하시겠습니까?")) {
		var url = "<%=cp%>/question/delete?code="+code+"&${query}";
		location.href=url;
	}
};


</script>


<table style="width: 100%; margin: 50px auto 0px; border-spacing: 0px; border-collapse: collapse;">

	<tr height="35">
	    <td colspan="2">
	        <span class="questionQ">Q</span><span class="questionSubject">[${dto.cateName}] ${dto.subject}</span>
	    </td>
	</tr>
	
	<tr height="35" style="border-bottom: 1px solid #cccccc;">
	    <td width="50%" align="left" style="padding-left: 5px;">
	         작성자 : ${dto.userName}
	     <c:if test="${sessionScope.member.adminId=='admin'}">(${dto.userId})</c:if>
	    </td>
	    <td width="50%" align="left" style="padding-right: 5px;">
	        문의일자 : ${dto.created}
	    </td>
	</tr>
	

	<tr>
	  <td colspan="2" align="left" style="padding: 10px 5px;" valign="top" height="90">
	      ${dto.content}
	   </td>
	</tr>
	

<c:if test="${dto.type==1}">
	<tr height="35">
	    <td colspan="2">
	       <span class="answerA">A</span><span class="answerSubject">[RE] ${dto.subject}</span>
	    </td>
	</tr>
	<tr height="35" style="border-bottom: 1px solid #cccccc;">
	    <td width="50%" align="left" style="padding-left: 5px;">
	         담당자 : ${adto.userId}
	    </td>
	    <td width="50%" align="left" style="padding-right: 5px;">
	        답변일자 : ${adto.created}
	    </td>
	</tr>
	
	<tr style="border-bottom: 1px solid #cccccc;">
	  <td colspan="2" align="left" style="padding: 10px 5px;" valign="top" height="90">
	      <div style="min-height: 75px; ">${adto.content}</div>
	      <c:if test="${sessionScope.member.adminId=='admin'}">
	         <div style="margin-top: 5px; margin-bottom: 5px; text-align: right;">
                 <button type="button" class="btn" onclick="deleteQuestion('${dto.code}');" ${sessionScope.member.adminId!="admin" ? "style='pointer-events:none;'":"" }>답변삭제</button>
	         </div>
	      </c:if>
	   </td>
	</tr>
</c:if>


<tr height="45" style="border-top: 1px solid #cccccc;">
    <td align="left">
      
	</td>
	<td align="right">
	   <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/question/list';">리스트</button>
	</td>
</tr>
</table>

<c:if test="${sessionScope.member.adminId=='admin'}">
<form name="boardForm" method="post" enctype="multipart/form-data">
<table style='width: 100%; margin: 15px auto 0px; border-spacing: 0px;'>
    <tr height='30'> 
        <td align='left'>
            <span style='font-weight: bold;' >답변 달기 - </span><span> 문의에 대한 답변을 입력 하세요</span>
        </td>
    </tr>
    <tr>
        <td style='padding:5px 5px 0px;'>
            <textarea name='content' class='boxTA' style='width:99%; height: 70px;'></textarea>
        </td>
    </tr>
    <tr>
        <td align='right'>
            <button type='button' class='btn btnSendReply' style='padding:10px 20px;'>답변 등록</button>
        </td>
    </tr>
</table>
    <input type="hidden" name="subject" value="${dto.subject}">
    <input type="hidden" name="cateName" value="${dto.cateName}">
    <input type="hidden" name="parent" value="${dto.code}">
</form>
</c:if>