<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<style>
.ll {
list-style:none;
margin:0px auto; width: 1000px;
}



.ll li{
display:block; width:130px; height:40px; background:tomato; color:#fff; border:1px black; font-size:12px; font-family:"돋움";
 text-align:center; padding-top:10px; text-decoration:none; float:left; list-style:none; margin: 1;
 }
 
.lo {
list-style:none;
float: left; 
}

.lo li{
list-style:none;
float: left;
}


.*{
font-family: 'Sunflower', sans-serif;

}

.center {
text-align: center;
}

.a1{

}
 </style>

<script type="text/javascript">

function eventUpdate() {
	var q = "ecode=${dto.ecode}&page=${page}";
	var url = "<%=cp%>/event/update?" + q;
	
	if(confirm("이벤트를 수정 하시겠습니까?"))
		location.href=url;
}

function eventDelete() {
	var q = "ecode=${dto.ecode}&${query}";
	var url = "<%=cp%>/event/delete?" + q;
	
	if(confirm("이벤트를 삭제 하시겠습니까?"))
		location.href=url;
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

//페이징 처리
$(function(){
	listPage(1);
});

function listPage(page) {
	var url = "<%=cp%>/event/listReply";
	var query = "rcode=${dto.rcode}&pageNo="+page;
	var selector = "#listReply";
	
	ajaxHTML(url, "get", query, selector);
}

//리플 등록
$(function(){
	$(".btnSendReply").click(function(){
		var rcode="${dto.rcode}";
		var $tb = $(this).closest("table");
		var content=$tb.find("textarea").val().trim();
		if(! content) {
			$tb.find("textarea").focus();
			return false;
		}
		content = encodeURIComponent(content);
		
		var url="<%=cp%>/event/insertReply";
		var query="rcode="+rcode+"&content="+content+"&answer=0";
		
		var fn = function(data){
			$tb.find("textarea").val("");
			
			var state=data.state;
			if(state=="true") {
				listPage(1);
			} else if(state=="false") {
				alert("댓글을 추가 하지 못했습니다.");
			}
		};
		
		ajaxJSON(url, "post", query, fn);
	});
});




</script>

 
 <div class="body-container" style="width: 1200px;">

<div style="width:100% ;height:100px; background: purple;">
공백
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

<div class="body-container" style="width: 700px;">
    <div class="body-title">
        <h3><i class="far fa-image"></i> ${dto.subject} </h3>
    </div>
    
    <div>
    	<table>
    		<tr style="width: 100%; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;">
        		<td width="40%" align="left" style="padding-right: 10px; border-spacing: 0px; border-collapse: collapse;">
			    	 이벤트 기간 : ${dto.sdate} ~ ${dto.edate}
				</td>
				<td width="40%" align="right" style="padding-right: 10px; border-spacing: 0px; border-collapse: collapse;">
				<c:if test="${event.lott != 0}">
			    	당첨자 발표 : ${dto.lottDate}
				</c:if>
				</td>
				
			</tr>
    	</table>
    	
    </div>
    <div style="width: 80%; margin: 10px auto 0px; text-align: center;">
    	<a href="${dto.elink}">
    		<img src="<%=cp%>/uploads/event/${dto.imageFilename}" width="70%" style="margin: 0px 10px;">
    	</a>

    	<table style="width: 100%; margin: 0px auto 20px; border-spacing: 0px; ">
			<tr height="45">
			    <td width="300" align="right">			    
			          <button type="button" class="btn" onclick="eventUpdate('${dto.ecode}');">수정</button>			    
			          <button type="button" class="btn" onclick="eventDelete('${dto.ecode}');">삭제</button>
			    </td>
			</tr>
			</table>
    </div>
	</div>

	<table style='width: 100%; margin: 15px auto 0px; border-spacing: 0px;'>
		<tr height='30'> 
			 <td align='left' >
				<span style='font-weight: bold;' >댓글${dto.scode}</span><span> - 타인을 비방하거나 개인정보를 유출하는 글의 게시를 삼가 주세요.</span>
			 </td>
		</tr>
		<tr>
			<td style='padding:5px 5px 0px;'>
				<textarea class='boxTA' style='width:99%; height: 70px;'></textarea>
		    </td>
		</tr>
		<tr>
			<td align='right'>
				<button type='button' class='btn btnSendReply' data-num='10' style='padding:10px 20px;'>댓글 등록</button>
			</td>
		</tr>
	</table>



</div>