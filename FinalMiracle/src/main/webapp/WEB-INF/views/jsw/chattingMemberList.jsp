<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>대화상대</title>

<style type="text/css">

.circle {
  width: 60px;
  height: 60px;
  border: 1px solid aqua;
  border-radius: 50%;
}


</style>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/jquery-2.0.0.js"></script>






<script type="text/javascript">
	
	function addPersonStart() {
		
		var cridx = $('#chattingRoomNum').val();
		var cridx_data = {cridx : cridx};
		
		$.ajax({
			url: "addPersonStart.mr",
			data: cridx_data,
			type: "get",		
			dataType: "html",	
			 					
			success: function(data) { 
										
										
				$("#chatMessage").empty(); 
				$("#memberinfo").empty();
				$("#chatMessage").html(data);
			},
			error: function(request, status, error) {
				alert("code: " + request.status + "\n"+"message: " + request.responseText + "\n" + "error: " + error);     
			}
		});
		$("#message").hide();
		$("#sendMessage").hide();
		
		
	}
	
	function outRoom() {
		
		var check = confirm("채팅방을 나가시겠습니까?\r\n(채팅방에서 나가셔도 채팅기록은 사라지지 않습니다.)");
		var cridx = $('#chattingRoomNum').val();
		var cridx_data = {cridx : cridx};
		
		if(check){
			$.ajax({
				url: "outRoom.mr",
				data: cridx_data,
				type: "get",		
				dataType: "html",	
				 					
				success: function(data) { 
																	
					$("#chatMessage").empty(); 
					$("#memberinfo").empty();
					$("#room").empty();
					$("#room").html(data);
					alert("채팅방에서 나갔습니다");
				},
				error: function(request, status, error) {
					alert("code: " + request.status + "\n"+"message: " + request.responseText + "\n" + "error: " + error);     
				}
			});
		}
		
		
		
		
	}
	
	
	
	
</script>



</head>
<body>
	<div style="font-size: 20px; text-align: left;">
		<div style="border-bottom: 1px solid black; text-align: center; height: 30px;">대화상대</div>
			<div onclick="addPersonStart()" style="cursor: pointer; color: aqua; margin: 5px;"><span class="circle" style="vertical-align: middle; font-size: 50px;">&nbsp;+ </span>&nbsp;대화상대 초대</div>
			<c:forEach var="member" items="${chattingMember}" varStatus="status">
				<div style="margin: 5px; margin-bottom: 10px;">
					<div onclick="" style="border: 0px solid blue; cursor: pointer;"><img height="60px" width="60px" class="img-circle" src="<%=request.getContextPath() %>/resources/files/${member.img}">
					<span style="color: black;">${member.name}</span></div>
					<input type="hidden" name="chattingRoomNum" id="chattingRoomNum" value="${member.cridx}"/>
				</div>
			</c:forEach>
			<div onclick="outRoom()" style="cursor: pointer; text-align: center; margin-top: 10px; border-top: 1px solid black;"><i class="glyphicon glyphicon-log-out"></i> 채팅방 나가기</div>
	</div>
</body>
</html>