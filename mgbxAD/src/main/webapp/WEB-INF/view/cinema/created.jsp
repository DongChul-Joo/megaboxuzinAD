<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.ui-dialog-content {
font-size: 10px;
font-weight:bold; 
}

.ui-widget-content{
font-size: 10px;
font-weight:bold; 
}
.dbtn{
width: 20px;
height: 20px;  
padding: 0;
text-align: center;
font-size: 10px;
font-weight:bold;   
background: white;
border: 1px solid black;  
}
.dbtns{
width: 22px;
height: 22px;  
padding: 0;
text-align: center;
font-size: 10px;
font-weight:bold;   
background: white;
border: 1px solid black;  
} 

.nbtn{
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

.nonBtn{
width: 20px;
height: 20px;  
pointer-events:none;
background: white;
border: none;
color: white;
}

.cinemaDIV{
float: left;
margin: 10px;
width: 1000px;
}


</style>

<script type="text/javascript">

var row=0;
var col=0;
var totseat=0;

$(document).on("click", ".dbtn", function() {
    this.setAttribute('class','nbtn');
    this.setAttribute('data-num',"1");
    totseat--;
});

$(document).on("click", ".nbtn", function() {
    this.setAttribute('class','dbtn');
    this.setAttribute('data-num',"0");
    totseat++;
});

function cinemaCreated(){
	row=parseInt($('input[name=rows]').val());
	col=parseInt($('input[name=column]').val());
	
	$("table[name=cinamaCreated]").remove();  
	
	var cinemaView="<table name='cinamaCreated'>";
		 
	for(var i=0;i<row;i++){
			var a = String.fromCharCode(65+i);
		cinemaView+="<tr><td class='dbtns'>"+a+"열</td><td>";
		for(var j=0;j<col;j++){
			cinemaView+="<button id='"+a+(j+1)+"' class='dbtn' data-num='0' data-row='"+a+"' data-col='"+(j+1)+"'>"+(j+1)+"</button>";
		}
		cinemaView+="</td></tr>";
	}
	cinemaView+="</table>";
	
	$("#cinemaView").append(cinemaView);  
	
	totseat=row*col;
}

$(function() {
	$("button[name=viewCinema]").click(function() {
		var cn=$('input[name=cName]').val();
		if(cn.trim()==""){
			alert("영화관 이름을 입력 해 주세요.");
			return;
		}
		
		var cl=$('input[name=cLocation]').val();
		if(cl.trim()==""){
			alert("영화관 위치를 입력 해 주세요.");
			return;
		}
		
		var cr=parseInt($('select[name=cRange]').val());
		alert(cr);
		if(cr==0){
			alert("상영 가능 범위를 지정 해 주세요.");  
			return;
		}
		
		
		var cinemaView = document.getElementById('cinemaView').innerHTML;
			cinemaView+="<button type='button' onclick='gogo()'>올리기</button>";
			
		var go="<input type='hidden' name='cmSeatMap' value='"+cinemaView+"'><input type='hidden' name='cmSeatTot' value='"+totseat+"'>"
		go+="<input type='hidden' name='cmName' value='"+cn+"'><input type='hidden' name='cmLocation' value='"+cl+"'>";
		go+="<input type='hidden' name='cmRange' value='"+cr+"'>";
		
		$("#category-dialog").append(cinemaView);
		$("#category-dialog").find("button.nbtn").setAttribute('class','nonbtn');
		$("#insertGo").append(go);
		
		$("#category-dialog").dialog({
			modal: true,
			height:500,
			width:700,
			title: "이름:"+cn+" 위치:"+cl+" 상영가능범위:"+(cr=="1"? "2D ONLY":"2D and 3D ")+" 총 좌석 수:"+totseat,
			close: function(event, ui) {
			}
		});
	});
	//$("#category-dialog").dialog("close"); 창닫기
});

function gogo(){
	
	var f=document.cinemaForm;
	f.action="<%=cp%>/cinema/created";
	f.submit();
	
}

</script>
</head>
<body>
<div>

	<div>
		<table>
			<tr>
				<td>영화관 행 수<input name="rows" type="number" min="0" max="20" >영화관  열 수<input name="column" type="number"  min="0" max="20" > <button type="button" onclick="cinemaCreated();">생성</button></td>
			</tr>
		</table>
	</div>


	<div> 
		<table>
			<tr>
				<td>관 이름<input name="cName" type="text"> </td>
			</tr>
		
			<tr>
				<td>관 위치<input name="cLocation" type="text" > </td>
			</tr>
		
			<tr>
				<td>상영 가능 범위  
					<select name="cRange">
						<option value="1">2D ONLY</option>
						<option value="2">2D and 3D </option>
					</select>
				</td>  
			</tr>
		</table> 
		<button name="viewCinema" type="button">가즈아</button>
		<div id="cinemaView">
		</div>
	</div>
	<div id="category-dialog" style="display: none;">
    </div>
<form name="cinemaForm" method="post">
	<div id="insertGo" style="display: none">
	</div>
</form>  

</div>

</body>
</html>