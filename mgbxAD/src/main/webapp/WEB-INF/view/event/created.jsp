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
	
	if(f.lott.checked) {
		f.mcount.readOnly=false;
		document.getElementById("lottCount").style.display="";
		document.getElementById("lottLottDate").style.display="";
		
		
	} else {
		f.mcount.readOnly=true;
		f.mcount.value="0";
		document.getElementById("lottCount").style.display="none";
		document.getElementById("lottLottDate").style.display="none";
	}

}


//작성 여부 얼러창 띄우기
function send() {
	var f = document.eventForm;
	
	var str;
	
	var str = f.subject.value;
	if(!str) {
		alert("제목을 입력해 주세요.");
		f.subject.focus();
		return;
	}
	
	var mode="${mode}";
	if(mode=="created"||mode=="update" && f.upload.value!="") {
		if(! /(\.gif|\.jpg|\.png|\.jpeg)$/i.test(f.upload.value)) {
			alert('이미지 파일만 가능합니다.(bmp 파일은 불가) !!!');
			f.upload.focus();
			return;
		}
	}
	
	f.action="<%=cp%>/event/${mode}";
	f.submit();
}
</script>

<div class="body-container" style="width: 830px;">
<div style="width:100% ;height:100px; background: purple;">
</div>

<div style="width: 100%; height:100px; background-color: white; ">
    <ul class="ll" > 
        <li><a href="<%=cp%>/event/list?ecategoryCode=0">전체</a></li>
        <li><a href="<%=cp%>/event/list?ecategoryCode=1">메가박수진이벤트</a></li>
        <li><a href="<%=cp%>/event/list?ecategoryCode=2">영화 이벤트</a></li>   
        <li><a href="<%=cp%>/event/list?ecategoryCode=3">제휴 이벤트</a></li>
        <li><a href="<%=cp%>/event/list?ecategoryCode=4">영화관이벤트</a></li>
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
				</td>
			</tr>

			  <tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
				<td width="100" bgcolor="#eeeeee" style="text-align: center;">응모 여부</td>
				<td style="padding-left:10px;"> 
					<label><input name="lott" type="checkbox" onclick="clickRott();" value="1" ${dto.lott==1 ? "checked='checked' ":"" }>여부</label>
					<label id="lottCount" style="display: none;" class="input-mcount">당첨자 수 : <input name="mcount" type="number" value="0" readonly="readonly"></label>
					<label id="lottLottDate" style="display: none;" class="input-lottDate">당첨자 발표일 : <input name="lottDate" type="date"></label>
					<label>${dto.rotbtn}</label>
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
			      <td align="center" style="padding-bottom: 20px">
			        <button type="button" class="btn" onclick="send();">${mode=='update'?'수정완료':'등록하기'}</button>
					<button type="button" class="btn">다시입력</button>
					<button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/event/list';">${mode=='update'?'수정취소':'등록취소'}</button>
						<c:if test="${mode=='update'}">
							<input type="hidden" name="ecode" value="${dto.ecode}">
							<input type="hidden" name="imageFilename" value="${dto.imageFilename}">
							<input type="hidden" name="page" value="${page}">
						</c:if>
					
			      </td>
			    </tr>
			  </table>
			</form>
    </div>
 
</div>