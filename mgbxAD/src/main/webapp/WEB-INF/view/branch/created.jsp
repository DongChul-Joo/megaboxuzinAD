<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<script type="text/javascript">
function branInsert() {
	var f = document.branchForm;
	var str;
    str = f.branName.value;
	str = str.trim();
    if(!str) {
        alert("지점명을 입력하세요. ");
        f.branName.focus();
        return;
    }
      
    str = f.areaCode.value;
    if(!str) {
        alert("지역 분류를 선택하세요. ");
        f.areaCode.focus();
        return;
    }
 
    str = f.branZip.value;
    if(!str) {
        alert("주소를 입력하세요. ");
        f.branZip.focus();
        return;
    }
    
    str = f.branAddr1.value;
    
    var ac=f.areaCode.value;
        ac=document.querySelector("option[name=area"+ac+"]").getAttribute('data-val');
        alert(ac);
    	alert(str.indexOf(ac));
    	
    if(str.indexOf(ac)<0||str.indexOf(ac)>1){
    	alert("주소지와 지역분류가 일치하지 않습니다.")
    	return;
    }
    
    str = f.branAddr2.value;
    if(!str) {
        alert("주소 상세를 입력하세요. ");
        f.branAddr2.focus();
        return;
    }
    
    str = f.upload.value;
    mode="${mode}";
    if(mode!="update"&&!str) {
        alert("지점 이미지를 올려주세요. ");
        f.upload.focus();
        return;
    }
    
    
    
 	f.action = "<%=cp%>/branch/${mode}";
 	f.submit();


}

<c:if test="${mode=='update'}">
$(function(){
	
	$("select[name=areaCode]").val("${dto.areaCode}");
	
	maps();
	
	 
});
</c:if>


</script>
<div class="body-container" style="width: 700px; padding-top: 30px;" >
    <div class="body-title">
        <h3><span style="font-family: Webdings"></span> ${mode=="created" ? "지점 등록":"지점 정보 수정"} </h3>
    </div>
    
        <div>
			<form name="branchForm" method="post" enctype="multipart/form-data">

			  <table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px;">
			
			  <tr>
			      <td width="100" valign="top" style="text-align: right; padding-top: 5px;">
			            <label style="font-weight: 900;">지점명</label>
			      </td>
			      <td style="padding: 0 0 15px 15px;">
			        <p style="margin-top: 1px; margin-bottom: 5px;">
			            <input type="text" name="branName" value="${dto.branName}" maxlength="30" class="boxTF"
		                      style="width: 95%;"
		                      placeholder="지점명">
			        </p>
			      </td>
			  </tr>
		
			   <tr>
			      <td width="100" valign="top" style="text-align: right; padding-top: 5px;">
			            <label style="font-weight: 900;">지역분류</label>
			      </td>
			      <td style="padding: 0 0 15px 15px;">
			        <p style="margin-top: 1px; margin-bottom: 5px;">
			           <select name="areaCode" style="margin-top: 5px;height: 25px;border-radius: 3px" >  
			           		<option value="">::지역 선택::</option>
			           			<c:forEach var="vo" items="${list}">
			           				<option name="area${vo.areaCode}" value="${vo.areaCode}" data-val="${vo.areaName}">${vo.areaName}</option>
			           			</c:forEach>
			           </select>
			        </p>
			      </td>
			  </tr>
			  
			  
			  <tr>
			      <td width="100" valign="top" style="text-align: right; padding-top: 5px;">
			            <label style="font-weight: 900;">우편번호</label>
			      </td>
			      <td style="padding: 0 0 15px 15px;">
			        <p style="margin-top: 1px; margin-bottom: 5px;">
			            <input type="text" name="branZip" id="branZip" value="${dto.branZip}"
			                       class="boxTF" readonly="readonly">
			            <button type="button" class="btn" onclick="daumPostcode();">우편번호</button>       
			        </p>
			      </td>
			  </tr>
			    
			   <tr>
			      <td width="100" valign="top" style="text-align: right; padding-top: 5px;">
			            <label style="font-weight: 900;">주소</label>
			      </td>
			      <td style="padding: 0 0 15px 15px;">
			        <p style="margin-top: 1px; margin-bottom: 5px;">
			            <input type="text" name="branAddr1" id="branAddr1"  value="${dto.branAddr1}" maxlength="50" 
			                       class="boxTF" style="width: 95%;" placeholder="기본 주소" readonly="readonly">
			        </p>
			        <p style="margin-bottom: 5px;">
			            <input type="text" name="branAddr2" id="branAddr2" value="${dto.branAddr2}" maxlength="50" 
			                       class="boxTF" style="width: 95%;" placeholder="나머지 주소">
			        </p>
			      </td>
			  </tr>
			
			  
			  <c:if test="${mode=='update'}">  
			  <tr>
			      <td width="100" valign="top" style="text-align: right; padding-top: 60px;">
			            <label style="font-weight: 900;">등록된 이미지</label>
			      </td>  
			      <td style="padding: 0 0 15px 15px;">
			            <img src="<%=cp%>/branchImg/branch/${dto.imageFilename}" style="width: 200px;height: 150px">
			      </td>
			  </tr>
			  </c:if>
			  
			  <tr>
			      <td width="100" valign="top" style="text-align: right; padding-top: 5px;">
			            <label style="font-weight: 900;">${mode=="update"? "이미지 수정":"지점 이미지"}</label>
			      </td>
			      <td style="padding: 0 0 15px 15px;">
			        <p style="margin-top: 1px; margin-bottom: 5px;">
			            <input type="file" name="upload" maxlength="30" class="boxTF" 
		                      style="width: 95%;">
			        </p>
			      </td>
			  </tr>
					  
			  </table>
			  <table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
			     <tr height="45"> 
			      <td align="center" > 
			        <button type="button" name="sendButton" class="btn" onclick="branInsert();">${mode=="created"?"지점등록":"수정완료"}</button>
			        <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/branch/list';">${mode=="created"?"등록취소":"수정취소"}</button>
			        <c:if test="${mode=='update'}">
			        	<input type="hidden" name="imageFilename" value="${dto.imageFilename}">
			        	<input type="hidden" name="branCode" value="${dto.branCode}">
			        </c:if>
			      </td>
			    </tr>
			  </table>
			  <div id="map" style="width:500px;height:400px; margin: 0px auto"></div>
			</form>
        </div>
        

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
    function daumPostcode() {
    	var branName=document.branchForm.branName.value;
    	if(branName.trim()==""){
    		alert("지점명을 입력한 후 주소를 입력해 주세요");
    		return;
    	}
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = ''; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수

                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    fullAddr = data.roadAddress;

                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    fullAddr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
                if(data.userSelectedType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('branZip').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('branAddr1').value = fullAddr;

                // 커서를 상세주소 필드로 이동한다.
                document.getElementById('branAddr2').focus();
                maps();
            }
     
        }).open();
        
    }
</script>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=04e4431a8f42ef7f22f5a23dfe0e8324&libraries=servicesappkey=APIKEY&libraries=services"></script>
	<script>
	function maps(){
		
		var addr1=$("#branAddr1").val();
		var branName=$("input[name=branName]").val();
		
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

</div>