<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<script type="text/javascript">

function sendOk() {
	var f = document.itemForm;
	
	var str = f.itemName.value;
	if(!str.trim()) {
		alert("상품명을 입력하세요.");
		f.itemName.focus();
		return;
	}
	
	str = f.itemPrice.value;
	if(!str.trim()) {
		alert("상품가격을 입력하세요.");
		f.itemPrice.focus();
		return;
	}
	if(!/^(\d+)$/.test(str)) {
		alert("판매가는 숫자만 입력가능합니다!");
		f.itemPrice.focus();
		return;
	}
	
	str = f.itemDetail.value;
	if(!str.trim()) {
		alert("상세정보를 입력하세요.");
		f.itemDetail.focus();
		return;
	}
	
	var mode="${mode}";
	if(mode=="created"||mode=="update" && f.upload.value!="") {
		if(! /(\.gif|\.jpg|\.png|\.jpeg)$/i.test(f.upload.value)) {
			alert('이미지 파일만 가능합니다.(bmp제외)');
			f.upload.focus();
			return;
		}
	}
	
	f.action = "<%=cp%>/item/${mode}";
	
	f.submit();
}

</script>

<div class="body-container" style="width: 1400px;">
	<div class="body-title">
			<h3><span>|</span> 스토어 등록</h3>
	</div>	
	
	<div>
	<form name="itemForm" method="post" enctype="multipart/form-data">
		<table style="width: 40%; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;">
			<tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;">
				<td width="100" bgcolor="#DAD9FF" style="text-align: center;">상품명</td>
				<td style="padding-left:10px;">
					<input type="text" name="itemName" maxlength="100" style="width: 170px;" value="${dto.itemName}">
				</td>
			</tr>
			<tr align="left" height="40" style="border-bottom: 1px solid #cccccc;">
				<td width="100" bgcolor="#DAD9FF" style="text-align: center;">분류</td>
				<td style="padding-left:10px;">
					<select name="itemPart">
						<option value="영화티켓">영화티켓</option>
						<option value="특별할인">특별할인</option>
						<option value="먹거리">먹거리</option>
					</select>
				</td>
			</tr>
			<tr align="left" height="40" style="border-bottom: 1px solid #cccccc;">
				<td width="100" bgcolor="#DAD9FF" style="text-align: center;">판매가</td>
				<td style="padding-left:10px;">
					<input type="text" name="itemPrice" value="${dto.itemPrice}">
				</td>
			</tr>
			<tr align="left" style="border-bottom: 1px solid #cccccc;">
				<td width="100" bgcolor="#DAD9FF" style="text-align: center; padding-top:5px;" valign="top">
					원산지
				</td>
				<td valign="top" style="padding:5px 0px 5px 10px;"><input type="text" name="itemOrigin" value="${dto.itemOrigin}"></td>
			</tr>
			<tr align="left" height="40" style="border-bottom: 1px solid #cccccc;">
				<td width="100" bgcolor="#DAD9FF" style="text-align: center;">이미지</td>
				<td style="padding-left:10px;">
					<input type="file" name="upload" class="boxTF" size="53" 
								accept="image/*" 
								style="height: 25px;">
				</td>
			</tr>
			<tr align="left" style="border-bottom: 1px solid #cccccc;">
				<td width="100" bgcolor="#DAD9FF" style="text-align: center; padding-top:5px;" valign="top">
					상세설명
				</td>
				
				<td valign="top" style="padding:5px 0px 5px 10px;">
					<p>
<textarea name="itemDetail" rows="12" style="width: 90%; resize: none;"><c:out value="${dto.itemDetail}"/>
·사용가능 영화관 : 전체 영화관

·유효기간 : 예매가능 유효기간은 구매일부터 2년간 입니다.(일자 기준)

·구매 후 취소 : 구매한 관람권 일괄 환불만 가능, 부분 환불 불가하며, 구매 일로 일주일 이내에만 취소가 가능합니다.</textarea>
</p>
				</td>
			</tr>
		</table>
		
		<table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
			<tr height="45">
				<td align="center">
				<button type="button" class="btn" onclick="sendOk();">${mode=='update'?'수정완료':'등록하기'}</button>
				<button type="reset" class="btn">다시입력</button>
				<button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/item/list';">${mode=='update'?'수정취소':'등록취소'}</button>
				<c:if test="${mode=='update'}">
					<input type="hidden" name="itemCode" value="${dto.itemCode}">
					<input type="hidden" name="itemImg" value="${dto.itemImg}">
					<input type="hidden" name="page" value="${page}">
				</c:if>
				</td>
			</tr>	
		</table>
	</form>
				
	</div>
</div>