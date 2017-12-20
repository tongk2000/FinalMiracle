<%@page import="org.springframework.web.context.request.SessionScope"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style type="text/css">
	


</style>

<script type="text/javascript">
	
	$(document).ready(function(){
		loopRoomList();
		$("#message").hide()
		$("#sendMessage").hide();

		
	        $("#message").keydown(function (key) {
	            if (key.keyCode == 13) {
	               $("#sendMessage").click();
	            }
	         });
	        
	   	 
	       $("#sendMessage").click(function() {
	    	//   scroll();
	    	//$("#chatMessage").scrollTop($("#chatMessage")[0].scrollHeight);
	    	   
	           if( $("#message").val() != "") {
	       		
	       		var roomid = $("#roomid").val();
	       		var msg = $("#message").val();
	    		
	    		var form_data = {cridx1 : roomid
	    						,message : msg};
	    		
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
	    				$("#chatMessage").scrollTop($("#chatMessage")[0].scrollHeight);
	    				
	    			},
	    			error: function(request, status, error) {
	    				alert("code: " + request.status + "\n"+"message: " + request.responseText + "\n" + "error: " + error);     
	    			}

	       			});
	    		
	    		}
	    		
	           loopRoomList();
	           $("#message").val("");
	         //  $("#chatMessage").scrollTop($("#chatMessage")[0].scrollHeight);
		});
	       
	       
	       
	}); // $(document).ready(function()
	
	
	
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
		$("#message").show();
		$("#sendMessage").show();
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
		$("#message").val("");
		
		$.ajax({
			url: "chattingMemberAjax.mr",
			data: form_data,
			type: "get",		// 위의 url주소로 보내어질 요청대이터이다
			dataType: "html",	// ajax 요청에의해 url주소(chattingRoomAjax.mr)로 리턴받는 데이터 타입이다
			 					// 종류가 xml, json, html, script, text
			success: function(data) { // success => url주소(chattingRoomAjax.mr)로 부터 받은 응답이 요청에 성공했다는 것을 말한다
										// function(data) {}를 콜백함수라고 부르는데 성공한 다음에 실행할것들을 여기에 서술한다
										// 그리고 data는 url주소(chattingRoomAjax.mr)로부터 리턴받은 데이터이다
				$("#memberinfo").empty(); // 해당요소 선택자 내용을 모두 비워서 새로운 데이터를 채울 준비를 한다
				$("#memberinfo").html(data);
			},
			error: function(request, status, error) {
				alert("code: " + request.status + "\n"+"message: " + request.responseText + "\n" + "error: " + error);     
			}
			
		});
		
		/*  setTimeout(function() {
			goChatRoom();
		},1000); */ 

	//	scroll();
	//	$("#chatMessage").scrollTop($(document).height());
		$("#chatMessage").scrollTop($("#chatMessage")[0].scrollHeight);
		getRoomList();
	     
	}
	    /* function scroll() {
		var divcount = ${divcount}
//		alert(divcount);
		var offset = $("#chat" + divcount).offset();
	       $("#chatMessage").animate({scrollTop : offset.top}, 100);
	       
		
	}    */
	 function newChattingRoom() {
		
		$.ajax({
			url: "newChatting.mr",
		//	data: form_data,
			type: "get",		// 위의 url주소로 보내어질 요청대이터이다
			dataType: "html",	// ajax 요청에의해 url주소(chattingRoomAjax.mr)로 리턴받는 데이터 타입이다
			 					// 종류가 xml, json, html, script, text
			success: function(data) { // success => url주소(chattingRoomAjax.mr)로 부터 받은 응답이 요청에 성공했다는 것을 말한다
										// function(data) {}를 콜백함수라고 부르는데 성공한 다음에 실행할것들을 여기에 서술한다
										// 그리고 data는 url주소(chattingRoomAjax.mr)로부터 리턴받은 데이터이다
				$("#chatMessage").empty(); // 해당요소 선택자 내용을 모두 비워서 새로운 데이터를 채울 준비를 한다
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
	
	
	 

	
	
</script>

<div style="width: 95%; height: 100%; border: 0px solid red; margin-left: 5%;" align="center">

	<div style="float: left; width: 200px; height: 550px; border: 1px solid red; overFlow: auto;">

	<div>채팅방 목록</div>
	<div style="border: 1px solid maroon;" onclick="newChattingRoom()">채팅방 만들기</div>
		<div style="border: 1px solid red;" id="room"></div>
		
	</div>
	<div style="float: left;">
	<div id="chatMessage" style="overFlow: auto; height: 550px; border: 1px solid blue; width: 550px; background-color: #a0c0d7;"></div>
    <input type="text" id="message" placeholder="메시지 내용" style="width: 90%; margin-top: 5px;"/>
    <input type="button" id="sendMessage" class="btn-info" value="전송" />
    <input type="hidden" id="roomid" />
    </div>
    <div id="memberinfo" style="overFlow: auto; width: 240px; height: 550px; border: 1px solid yellow; float: left;"></div>
    <i class="fa fa-comments"></i>
    
</div>
