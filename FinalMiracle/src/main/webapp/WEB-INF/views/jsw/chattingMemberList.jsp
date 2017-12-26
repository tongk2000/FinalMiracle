<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style type="text/css">
	.circle {
	  width: 40px;
	  height: 40px;
	  border: 2px solid white;
	  border-radius:50%;
	}
</style>

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
				$("#newChattingRoom").remove();
				$("#roominfo").hide();
				$("#chatMessage").hide();
				$("#message").hide();
				$("#sendMessage").hide();
				
				$("#chatMessage").empty(); 
				$("#memberinfo").empty();
				$("#chattingMiddle").append(data);
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

<div style="border-bottom:1px solid white; text-align: center; margin-top:10px; height: 30px;">
	대화상대
</div>

<div onclick="addPersonStart()" style="cursor: pointer; margin: 5px;">
	<span class="circle" style="vertical-align: middle; font-size: 30px;">
		&nbsp;+
	</span>
	&nbsp;대화상대 초대
</div>

<div style="width:100%; min-height:83%; margin:5px; overFlow-Y:auto; overFlow-X:hidden;">
	<c:forEach var="member" items="${chattingMember}" varStatus="status">
		<div style="margin-bottom:10px;">
			<div onclick="" style="border: 0px solid blue; cursor: pointer;">
				<img height="40px" width="40px" class="img-circle" src="<%=request.getContextPath() %>/resources/files/${member.img}">
				<span>${member.name}</span>
			</div>
			<input type="hidden" name="chattingRoomNum" id="chattingRoomNum" value="${member.cridx}"/>
		</div>
	</c:forEach>
</div>
<div onclick="outRoom()" style="cursor: pointer; text-align: center; margin-top: 10px; padding-top :13px; padding-bottom: 3px; border-top: 1px solid white;">
	<i class="glyphicon glyphicon-log-out"></i> 채팅방 나가기
</div>





















