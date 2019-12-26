<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<script type="text/javascript">
function listPage(query) {
	
	var url="<%=cp%>/branch/list";
	var selector = "#tab-content";
	
	ajaxHTML(url, "get", query, selector);
}

// 검색
function searchList(areaCode,page) {
	
	var query="pageNo="+page+"&areaCode="+areaCode;
	listPage(query);
}

$(function(){
	var query="pageNo=1";
	listPage(query);
});

function ajaxHTML(url, type, query, selector) {
	$.ajax({
		type:type
		,url:url
		,data:query
		,success:function(data) {
			$(selector).html(data);
		}
	});
}


function listCinema(branCode,branName){
	 var url="<%=cp%>/cinema/list";
	 var query="branCode="+branCode;
	 var type="post";
	 $.ajax({
			type:type
			,url:url
			,data:query
			,dataType:"json"
			,success:function(data) {
				$("#viewCinemas").empty(); 
				var cinemaView="<div >";
				for(var i=0;i<data.length;i++){ 
					cinemaView+="<div style='margin-left:80px;margin-bottom:30px;'><table style='font-size:12px;'>";
					cinemaView+="<tr><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;이름:</td><td>&nbsp;"+data[i].cmName+"</td></tr>";
					cinemaView+="<tr><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;번호:</td><td>&nbsp;No_"+data[i].cmCode+"</td></tr>";
					cinemaView+="<tr><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;위치:</td><td>&nbsp;"+data[i].cmLocation+"</td></tr>";
					cinemaView+="<tr><td>상영 범위:</td><td>&nbsp;"+data[i].cmRange+"</td></tr>";
					cinemaView+="<tr><td>총 좌석수:</td><td>&nbsp;"+data[i].cmSeatTot+" 석</td></tr></table>";
					cinemaView+=data[i].cmSeatMap+"<button class='btn' type='button' onclick='updateCinema(\""+branCode+"\",\""+branName+"\",\""+data[i].cmCode+"\")'>관 수정</button><button class='btn' type='button' onclick='deleteCinema(\""+data[i].cmCode+"\")'>삭제</button>";
					cinemaView+="</div><p>-------------------------------------------------------------------</p>"; 
				 
				}
				cinemaView+="</div>";
				$("#viewCinemas").append(cinemaView);
				
				$("#viewCinemas").dialog({
					modal: true,
					height:550,
					width:550,
					title: "영화관 목록", 
					buttons: {
					       " 관 등록 " : function() {
					    	   insertCinema(branCode,branName);
					        },
					        "돌아가기 " : function() {
					        	  $(this).dialog("close");
						        },
					  },
					close: function(event, ui) {
					}
				});
			}
		    ,error:function(jqXHR) {
		
		    }
		});
}

function insertCinema(branCode,branName){
	 
	 location.href = "<%=cp%>/cinema/created?branCode="+branCode+"&branName="+encodeURIComponent(branName);
	 
}

function updateCinema(branCode,branName,cmCode){
	 
	 location.href = "<%=cp%>/cinema/update?branCode="+branCode+"&branName="+encodeURIComponent(branName)+"&cmCode="+cmCode;
	 
}

function deleteCinema(cmCode){
	 
	 location.href = "<%=cp%>/cinema/delete?cmCode="+cmCode;
	 
}
</script>



	<div id="tab-content" style="width: 100%"></div>
	
	
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=04e4431a8f42ef7f22f5a23dfe0e8324&libraries=servicesappkey=APIKEY&libraries=services"></script>
	<script>
function maps(addr,bn){
		
	var addr1=addr;
	var branName=bn;
	
	
	$("#map").dialog({
		modal: true,
		height:700,
		width:800,
		title: "",
		close: function(event, ui) {
		}
	});
	
		
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = {
	        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	    };  

	// 지도를 생성합니다    
	var map = new kakao.maps.Map(mapContainer, mapOption); 

	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();

	// 주소로 좌표를 검색합니다
	geocoder.addressSearch(addr1, function(result, status) {

	    // 정상적으로 검색이 완료됐으면 
	     if (status === kakao.maps.services.Status.OK) {

	        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

	        // 결과값으로 받은 위치를 마커로 표시합니다
	        var marker = new kakao.maps.Marker({
	            map: map,
	            position: coords
	        });

	        // 인포윈도우로 장소에 대한 설명을 표시합니다
	        var infowindow = new kakao.maps.InfoWindow({
	            content: '<div style="width:150px;text-align:center;padding:6px 0;">'+branName+'</div>'
	        });
	        infowindow.open(map, marker);

	        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
	        map.setCenter(coords);
	    } 
	    
	    
	});    
	}
	</script>
