<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>


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
			console.log(jQXHR.responseText);
		}
	});
}
// 데이터 넣기
$(function(){
	$("select[name=groupeCategoryNum]").change(function() { // 기존의 내용 지워주기
		$("select[name=eCategoryNum]").find("option").remove();
		$("select[name=eCategoryNum]").append("<option value=''>:: 과목 선택 ::</option>");
		
		var ecode=$(this).val();
		if(! num) {
			return false;
		}
		
		var url="<%=cp%>/event/listSubCategory";
		var query="eCategoryNum="+ecode;
		var fn=function(date) {
			for(var i=0; i<data.list.length; i++) {
				var eCategoryNum = data.list[i].eCategoryNum;
				var ecategoryName = data.list[i].eCategoryName;
				
				$("select[name=eCategoryNum]").append("<option value='"+eCategoryNum+"'>"+eCategoryName+"</option>");
			}
		};
		ajaxJSON(url, "get", query, fn)
	})
});


// 당첨자 수 체크 여부
function clickRott() {
	var f=document.eventForm;
	
	if(f.rott.checked) {
		f.mcount.readOnly=false;
		document.getElementById("rottCount").style.display="";
		
	} else {
		f.mcount.readOnly=true;
		f.mcount.value="0";
		document.getElementById("rottCount").style.display="none";
	}
}

//기입 여부 얼러창 띄우기
function send() {
	var f = document.eventForm;
	
	var str;
	
	str = f.subject.value;
	if(!str) {
		alert("제목을 입력해 주세요.");
		f.subject.focus();
		return;
	}
/*	
	str = f.groupeCategoryNum.value;
	if(!str) {
		alert("분류 옵션을 선택해 주세요.");
		f.groupeCategoryNum.focus();
		return;
	}
	str = f.sDate.value;
	if(!str) {
		alert("시작일을 선택해 주세요.");
		f.sDate.focus();
		return;
	}
	str = f.eDate.value;
	if(!str) {
		alert("종료일을 선택해 주세요.");
		f.eDate.focus();
		return;
	}
	*/
	
	f.action="<%=cp%>/event/${mode}";
	f.submit();
}
</script>

<div class="body-container" style="width: 830px;">
<div style="width:100% ;height:100px; background: purple;">
</div>

<div style="width: 100%; height:100px; background-color: white; ">
    <ul class="ll" > 
        <li><a href="<%=cp%>">전체</a></li>
        <li><a href="<%=cp%>">메가박수진이벤트</a></li>
        <li><a href="<%=cp%>">영화 이벤트</a></li>   
        <li><a href="<%=cp%>">제휴 이벤트</a></li>
        <li><a href="<%=cp%>">영화관이벤트</a></li>
        <li><a href="<%=cp%>">당첨자발표</a></li>
        <li><a href="<%=cp%>">현황 통계</a></li>
    </ul>
</div>
    
    <div>    
			<form name="eventForm" method="post"  enctype="multipart/form-data">
			  <table style="width: 115%; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;">
			  <tbody id="boardBody">
			  <tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
			      <td width="100" bgcolor="#eeeeee" style="text-align: center;">제&nbsp;&nbsp;&nbsp;&nbsp;목</td>
			      <td style="padding-left:10px;"> 
			        <input type="text" name="subject" maxlength="100" class="boxTF" style="width: 95%;" value="${dto.subject}">
			      </td>
			  </tr>
			  
			  <tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
				<td width="100" bgcolor="#eeeeee" style="text-align: center;">이벤트 정보</td>
					<td style="padding-left:10px;"> 
				<select class="boxTF" name="ecategoryCode" style="width: 15%;">
					<option value="">:: 분류 옵션 ::</option>
					<c:forEach var="vo" items="${list}">
						<option value="${vo.ecategoryCode}">${vo.ecategoryName}</option>
					</c:forEach>
				</select>
				<label>시작일 : <input name="sdate" type="date"></label>
				<label>종료일 : <input name="edate" type="date"></label>
				
				<label>응모여부 : <input name="rott" type="checkbox" style="width: 20%;" onclick="clickRott();"></label>
				<label id="rottCount" style="display: none;" class="input-mcount">당첨자 수 : <input name="mcount" type="number" style="width: 10%;" value="0" readonly="readonly"></label>
				</td>
			</tr>
			
			  <tr align="left" style="border-bottom: 1px solid #cccccc;"> 
				<td width="100" bgcolor="#eeeeee" style="text-align: center; padding-top:5px;" valign="top">내&nbsp;&nbsp;&nbsp;&nbsp;용</td>
					<td valign="top" style="padding:5px 0px 5px 10px;"> 
						<textarea name="content" id="content" class="boxTA" style="width:95%; resize: none; height: 270px;">${dto.content}</textarea>
			</td>
			  
			  <tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
			      <td width="100" bgcolor="#eeeeee" style="text-align: center;">링&nbsp;&nbsp;&nbsp;&nbsp;크</td>
			      <td style="padding-left:10px;"> 
			        <input type="text" name="elink" maxlength="100" class="boxTF" style="width: 95%;" value="${dto.elink}">
			      </td>
			  </tr>
			  
			  <tr align="left" height="40" style="border-bottom: 1px solid #cccccc;">
			      <td width="100" bgcolor="#eeeeee" style="text-align: center;">첨&nbsp;&nbsp;&nbsp;&nbsp;부</td>
			      <td style="padding-left:10px;"> 
			          <input type="file" name="upload" class="boxTF" size="53" accept="image/*" style="width: 95%; height: 25px;" >
			       </td>
			  </tr>

			  </tbody>
			  </table>
			
			  <table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
			     <tr height="45"> 
			      <td align="center" >
			        <button type="button" class="btn" onclick="send()">등록하기</button>
					<button type="button" class="btn" onclick="">다시입력</button>
					<button type="button" class="btn" onclick="">등록취소</button>
			      </td>
			    </tr>
			  </table>
			</form>
    </div>
 
</div>