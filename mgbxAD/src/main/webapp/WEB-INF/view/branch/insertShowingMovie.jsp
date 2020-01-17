<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<style>
.ui-widget-header {
	background: none;
	border: none;
	height:35px;
	line-height:35px;
	border-bottom: 1px solid #cccccc;
	border-radius: 0px;
}
</style>

<script type="text/javascript">

function ajaxHTML(url, type, query, selector) {
	$.ajax({
		type:type
		,url:url
		,data:query
		,success:function(data) {
			$(selector).html(data);
			console.log(data);
		}
	});
}

function modalExit() {
	$("#showDetail").dialog("close");
}

function selectCinema(cmCode){
	document.movieForm.cmCode.value=cmCode;
	$("#movieInfo-dialog").dialog({
		modal: true,
		height:1000,
		width:900,
		title: "상영 영화 선택", 
		open:function(){
        },
		close: function(event, ui) {
		}
	});
}

function insertForm(movieCode){
	document.movieForm.movieCode.value=movieCode;
	$("#insertShowingMovie-dialog").dialog({
		modal: true,
		height:250,
		width:400,
		title: "상영 영화 등록", 
		open:function(){
        },
		close: function(event, ui) {
		}
	});
}

function insertShowingMovie(){
	
	
	var f = document.movieForm;

 	var showingStart = f.showingStart.value;
     if(!showingStart) {
         alert("상영 시작일을 입력하세요. ");
         showingStart.focus();
         return;
     }
     
     var showingEnd = f.showingEnd.value;
     if(!showingEnd) {
         alert("상영 종료일을 입력하세요. ");
         showingEnd.focus();
         return;
     }
	
	var url="<%=cp%>/branch/insertMovie";
	
	var movieCode=$("input[name=movieCode]").val();
	var cmCode=$("input[name=cmCode]").val();
	
	console.log(movieCode);
	console.log(cmCode);
	var query= "movieCode="+movieCode+"&cmCode="+cmCode+"&showingStart="+showingStart+"&showingEnd="+showingEnd;
	var type="post";
	
	
	$.ajax({
		type:type
		,url:url
		,data:query
		,dataType:"json"
		,success:function(data) {
			var state = data.state;
			if(state="true"){
				alert("등록 완료");
			} else {
				alert("등록 완료.");
			}
		}
	    ,error:function(jqXHR) {
	    	console.log(jqXHR);
	    }
	});
     
}

</script>


<div style="width: 1000px; min-height: 500px; margin: 0px auto;">
	<h1>영화 스케쥴 등록하기</h1>
	<img src="https://envato-shoebox-0.imgix.net/
	a30b/09d2-6475-470e-86b5-6418fc1842e7/
	DSC_8482.jpg?auto=compress%2Cformat&fit=max&mark=https%3A%2F%2Felements-assets.envato.com%
	2Fstatic%2Fwatermark2.png&markalign=center%2Cmiddle&markalpha=18&w=800&s=b0177c523f80b53edd4d59a8387250c7" >
	
	<c:forEach var="vo" items="${list2}">
		<div style="width:250px;  float: left; margin: 0px auto; margin-bottom: 100px;">
			<input type="hidden" class="getCinemaCode" value="${vo.cmCode}">
			<p><strong>${vo.cmName} 관정보</strong></p>
			<br>
			<p>상영 범위 : ${vo.cmRangeName} </p>
			<br>
			<p>총 좌석수 : ${vo.cmSeatTot} 석</p>
			<br>
			<button type="button" class="btn" onclick="selectCinema('${vo.cmCode}')">상영 영화 등록하기</button>
			<br><br>
			<button type="button" class="btn" onclick="selectCinema('${vo.cmCode}')">상영 시간 등록하기</button>
		</div>
	</c:forEach>	
</div>


<div id="movieInfo-dialog" style="display: none;">
	<c:forEach var="vo" items="${list}">
		<div style="width:200px; height: 250px; float: left; margin: 0px auto;">
			<img src="${vo.thumbNail}" style="width: 130px; height: 150px;">
			<p>${vo.movieNm}</p>
			<button type="button" class="btn" onclick="insertForm('${vo.movieCode}')">등록</button>
		</div>
	</c:forEach>
</div>

<div id="insertShowingMovie-dialog" style="display: none;">
	<form name="movieForm" method="post">
		<div style="margin-bottom: 25px;">
			<span>영화 상영 시작일(2020-00-00) :</span> <input name="showingStart" type="text" style="width=65px;">
		</div>	
		<div>
			<span>영화 상영 종료일(2020-00-00) :</span> <input name="showingEnd" type="text" style="width=65px;">
		</div>
		<input type="hidden" name="movieCode">
		<input type="hidden" name="cmCode">
		<button type="button" class="btn" style="float: right; margin-top:22px;" onclick="insertShowingMovie();">등록</button>
	</form>
</div>