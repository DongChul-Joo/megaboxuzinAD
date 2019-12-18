<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<style>
.box1 {
	float:left; width:500px; height:100px;}
.box2 {
  float:left;  width:500px; height:100px;
}
</style>

<script type="text/javascript">
function deleteItem() {

		var q = "itemCode=${dto.itemCode}&${query}";
		var url = "<%=cp%>/item/delete?" + q;
		
		if(confirm("위 상품을 삭제하시겠습니까?"))
			location.href=url;

}

function updateItem() {

		var q = "itemCode=${dto.itemCode}&page=${page}";
		var url = "<%=cp%>/item/update?" + q;
		location.href=url;

}

$(function(){
	$(".btn_plus").click(function(){
		var price = $(this).attr("data-price");
		
		var su = $("#itemCount").val();
		if(su=="") {
			su = 1;
		} else {
			su = parseInt(su);
		}
		if(su>=10) {
			alert("계산 범위를 벗어났습니다.");
			return false;
		}		
		su++;
	
		$("#itemCount").val(su);			
		var amt = price * su;	
		$("#payAmt").html(amt);
		
	});
});

$(function(){
	$(".btn_sub").click(function(){
		var price = $(this).attr("data-price");
		
		var su = $("#itemCount").val();
		if(su=="") {
			su = 1;
		} else {
			su = parseInt(su);
		}
		if(su<=1) {
			alert("계산 범위를 벗어났습니다.");
			return false;
		}
		su--;
		
		$("#itemCount").val(su);		
		var amt = price * su;	
		$("#payAmt").html(amt);
	});	
});

</script>

<div class="body-container" style="width: 1200px;">
	<div class="body-title">
		<h3> 상품정보 </h3>
	</div>

  <div style="clear: both;">
	<div class="box1">
		<h3>판매기간 : 2019-12-12~</h3>		
		 <p>
			<img src="<%=cp%>/uploads/item/${dto.itemImg}" width="380">
		 </p>	
	</div>
	
	<div class="box2">
		<div class="itemName">
			<h2>${dto.itemName}</h2>
			<span>${dto.itemPart}</span>
		</div>
		<div class="itemDetail">
			<ul class="detail">
				<li class="detail">
					<p>
						${dto.itemDetail}
					</p>
				</li>
				<li class="itemDetail2">
					<p>
						<strong>
							스토어 판매가
						</strong>
						<span>

							${dto.itemPrice}
						</span>
					</p>
					<div>
						<p class="itemAmount">
							<strong> 수량 : </strong>
							<button type="button" class="btn_sub" title="수량 1 감소" data-price="${dto.itemPrice}">-</button>
							<input type="text"  id="itemCount" style="width: 50px;" title="티켓 수량 입력" value="1" readonly>
							<button type="button" class="btn_plus" title="수량 1 증가" data-price="${dto.itemPrice}">+</button>
						</p>	
					</div>
				</li>
				<li class="totalAmount">
					<p>
						<span>
							<span id="payAmt">${dto.itemPrice}</span>원
						</span>
					</p>
					<p>
						<strong>
							
							* 구매 전 상품과 수량을 확인했습니다.*
						</strong>
					</p>
					
					<button type="button" onclick="">구매하기</button>
					<button type="button" onclick="javascript:location.href='<%=cp%>/item/list';">뒤로가기</button>
					<button type="button" onclick="updateItem();">상품수정</button>
					<button type="button" onclick="deleteItem();">상품삭제</button>
					
				</li>
			</ul>
		</div>
		
  	</div>	

	</div>
</div>