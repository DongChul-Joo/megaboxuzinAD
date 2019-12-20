<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<style type="text/css">
.ui-dialog-content {
font-size: 10px;
font-weight:bold; 
}

.ui-widget-content{
font-size: 10px;
font-weight:bold; 
}
.selectSeat{
width: 20px;
height: 20px;  
padding: 0;
text-align: center;
font-size: 10px;
font-weight:bold;   
background: white;
border: 1px solid black;  
}

.seatSelect{
width: 20px;
height: 20px;  
padding: 0;
text-align: center;
font-size: 10px;
font-weight:bold;   
background: white;
border: 1px solid black;  
}
.seatRows{
width: 22px;
height: 22px;  
padding: 0;
text-align: center;
font-size: 10px;
font-weight:bold;   
background: white;
border: 1px solid black;  
} 

.noneSeat{
width: 20px;
height: 20px;  
padding: 0;
text-align: center;
font-size: 9px;
font-weight:bold;   
background: purple;
border: 1px solid black;
color: white
}

.deleteSeat{
width: 20px;
height: 20px;  
pointer-events:none;
background: white;
border: none;
color: white;
}


</style>
<script type="text/javascript">
 function listCinema(branCode){
	 var url="<%=cp%>/cinema/list";
	 var query="branCode="+branCode;
	 var type="post";
	 
	 $.ajax({
			type:type
			,url:url
			,data:query
			,dataType:"json"
			,success:function(data) {
				$("#map").find().remove();
					alert(data);
				for(var i=0;i<data.length;i++){
					$("#map").append(data[i].cmSeatMap);
				}
				
				$("#map").dialog({
					modal: true,
					height:700,
					width:800,
					title: "",
					close: function(event, ui) {
					}
				});
			}
		    ,error:function(jqXHR) {
		
		    }
		});
 }
  
 </script>
    

<div class="menu" style=" width: 100%; background-color: white; padding: 0;margin: 0px; border: none;">
    <ul class="nav" style=" margin:0px auto ; width: 1500px;">  
        <c:forEach var="vo" items="${areaList}">
			 <li><a  style="width: 30px;line-height: 50px;color:white;background-color: #221f1f; border: none; href="<%=cp%>/branch/list?areaCode=${vo.areaCode}">${vo.areaName}</a></li>
		</c:forEach>	
    </ul>

</div>
<div class="body-container" style="width: 700px; padding-top: 30px;" >

 <c:forEach var="dto" items="${list}">
	<div style="width: 800px; height:150px; margin-bottom: 20px" >    
			
			<div style="width: 25%; height:100%; border:1px solid black ; 
			border-right:1px solid white; float: left" onclick="maps('${dto.branAddr1}','${dto.branName}');">
				<img src="<%=cp%>/branchImg/branch/${dto.imageFilename}" width="100%"
				height="100%" border="0" onclick="maps('${dto.branAddr1}','${dto.branName}');">
			</div>
			
			<div style="width: 60%;height:100%;float: left;border: 1px solid black" 
			onclick="maps('${dto.branAddr1}','${dto.branName}');">    
					<div style="width: 100%;height: 25%; border-bottom:  1px solid black">
						<p style="margin: 5px; margin-left: 38px; margin-top: 10px">지점명 : ${dto.branName}</p>
					</div>  
				  
					<div style="width: 100%;height: 70%;"> 
						<p style="margin: 5px; margin-left: 38px;margin-top: 20px;">우편번호 : ${dto.branZip}</p>
						<p style="margin: 5px; margin-top: 10px;margin-left: 38px;margin-top: 20px;">주소 : ${dto.branAddr1}&nbsp;${dto.branAddr2}</p>
					</div>
			</div> 
			<div style="width: 10%; float: left ;"  >
				<button class="btn" style="width: 65px; height:50px; border: 1px solid black;border-left:none; border-radius: 0; font-weight:bold;
					border-spacing: 0;border-collapse: collapse;" type="button" onclick="listCinema('${dto.branCode}')">관목록</button>
				<br>
				<button class="btn" style="width: 65px;height:51px; border: 1px solid black;border-top:none; border-left:none;  font-weight: bold;
					 border-radius: 0; border-spacing: 0;border-collapse: collapse;"" type="button" onclick="javascript:location.href='<%=cp%>/branch/update?branCode=${dto.branCode}'">수정</button>
				<br>
				<button class="btn" style="width: 65px;height:51px; border: 1px solid black;border-top:none; border-left:none; font-weight: bold;
					 border-radius: 0; border-spacing: 0;border-collapse: collapse;"" type="button" onclick="javascript:location.href='<%=cp%>/branch/delete?branCode=${dto.branCode}'">삭제</button>
			</div>
	</div>
	</c:forEach>    

<button class="btn" type="button" onclick="javascript:location.href='<%=cp%>/branch/created'">지점등록</button>
<button class="btn" type="button" onclick="javascript:location.href='<%=cp%>/cinema/created'">관등록</button><button class="btn" type="button" onclick="javascript:location.href='<%=cp%>/cinema/update'">관수정</button>
	
</div>
		<div id="map" style="display: none;height: 700px;width: 800px;">
		</div>

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
