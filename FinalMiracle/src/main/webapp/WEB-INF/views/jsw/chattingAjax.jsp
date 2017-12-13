<%@page import="org.springframework.web.context.request.SessionScope"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style type="text/css">
	
	

</style>

<script type="text/javascript">
	
	$(document).ready(function(){
		loopRoomList();

		
	        $("#message").keydown(function (key) {
	            if (key.keyCode == 13) {
	               $("#sendMessage").click();
	            }
	         });
	        
	   	 
	       $("#sendMessage").click(function() {
	       	
	           if( $("#message").val() != "") {
	           	var frm = document.sendFrm;
	       		frm.cridx1.value = $("#roomid").val();
	       		frm.message1.value = $("#message").val();
	       		
	       		frm.method = "get";
	       		frm.action = "<%= request.getContextPath() %>/chattingContentAjax.mr";
	       		frm.submit();
	           }

	       });
		

		
	});
	
	function getRoomList() {
		$.ajax({
			url: "chattingRoomAjax.mr",
			type: "get",		// 위의 url주소로 보내어질 요청대이터이다
			dataType: "html",	// ajax 요청에의해 url주소(chattingRoomAjax.mr)로 리턴받는 데이터 타입이다
			 					// 종류가 xml, json, html, script, text
			success: function(data) { // success => url주소(chattingRoomAjax.mr)로 부터 받은 응답이 요청에 성공했다는 것을 말한다
										// function(data) {}를 콜백함수라고 부르는데 성공한 다음에 실행할것들을 여기에 서술한다
										// 그리고 data는 url주소(chattingRoomAjax.mr)로부터 리턴받은 데이터이다
				$("#room").empty(); // 해당요소 선택자 내용을 모두 비워서 새로운 데이터를 채울 준비를 한다
				$("#room").html(data);
			},
			error: function(request, status, error) {
				alert("code: " + request.status + "\n"+"message: " + request.responseText + "\n" + "error: " + error);     
			}
		});
	}
	
	function loopRoomList() {
		getRoomList();
		
		 /* setTimeout(function() {
			loopRoomList();
		},1000);  */
	}
	
	function goChatRoom(s) {
		
		$("#roomid").val(s);
		
		var form_data = {cridx : s};
		
		$.ajax({
			url: "chattingContentAjax.mr",
			data: form_data,
			type: "get",		// 위의 url주소로 보내어질 요청대이터이다
			dataType: "html",	// ajax 요청에의해 url주소(chattingRoomAjax.mr)로 리턴받는 데이터 타입이다
			 					// 종류가 xml, json, html, script, text
			success: function(data) { // success => url주소(chattingRoomAjax.mr)로 부터 받은 응답이 요청에 성공했다는 것을 말한다
										// function(data) {}를 콜백함수라고 부르는데 성공한 다음에 실행할것들을 여기에 서술한다
										// 그리고 data는 url주소(chattingRoomAjax.mr)로부터 리턴받은 데이터이다
				$("#chatMessage").empty(); // 해당요소 선택자 내용을 모두 비워서 새로운 데이터를 채울 준비를 한다
				$("#chatMessage").html(data);
			},
			error: function(request, status, error) {
				alert("code: " + request.status + "\n"+"message: " + request.responseText + "\n" + "error: " + error);     
			}
			
		});
		
		/* setTimeout(function() {
			goChatRoom();
		},1000);  */

		scroll();
		
	     
	}
	function scroll() {
		var divcount = ${divcount}
		var offset = $("#chat" + divcount).offset();
	       $("#chatMessage").animate({scrollTop : offset.top}, 400);
		
	}
	
	
	
	 

	
	
</script>


<div style="float: left; width: 200px; height: 500px; border: 1px solid red;">

	채팅방 목록
		<div style="border: 1px solid red;" id="room"></div>
		
	</div>
	<div style="float: left;">
	<div id="chatMessage" style="overFlow: auto; height: 500px; border: 1px solid blue; width: 600px;"></div>
    <input type="text" id="message" placeholder="메시지 내용"/>
    <input type="button" id="sendMessage" value="전송" />
    <input type="text" id="roomid" />
    </div>
<form name="sendFrm">
	<input type="text" name="cridx1" id="cridx1" />
	<input type="text" name="message1" id="message1" />
</form>
