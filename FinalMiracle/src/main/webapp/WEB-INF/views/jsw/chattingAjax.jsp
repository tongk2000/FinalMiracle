<%@page import="org.springframework.web.context.request.SessionScope"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style type="text/css">
	
/* .overFlow{overflow: auto;} */

/* div.memberinfo:hover {
	           overflow: auto;
	       } */


::-webkit-scrollbar {
    width: 6px;
}
 
/* Track */
::-webkit-scrollbar-track {
    -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.0); 
    -webkit-border-radius: 10px;
    border-radius: 10px;
}
 
/* Handle */
::-webkit-scrollbar-thumb {
    -webkit-border-radius: 10px;
    border-radius: 10px;
    background:  rgba(0,0,0,0.0);
    -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.5); 
}
::-webkit-scrollbar-thumb:window-inactive {
	background:  rgba(0,0,0,0.0);
}

.modal.modal-center {
	  text-align: center;
	}
	@media screen and (min-width: 400px) { 
	  .modal.modal-center:before {
	    display: inline-block;
	    vertical-align: middle;
	    content: " ";
	    height: 100%;
	  }
	}
	.modal-dialog.modal-center {
	  display: inline-block;
	  text-align: left;
	  vertical-align: middle; 
	}


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
	       
	       
/* 	       $("#memberinfo").mouseover(function() {
	    	   $("#memberinfo").addClass("overFlow");
		});
	       
	       $("#memberinfo").mouseout(function() {
	    	   $("#memberinfo").removeClass("overFlow");
		}); */
	       
		


			
	       
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
				$("#newChattingRoom").remove();
				$("#addPerson").remove();
				$("#roominfo").show();
				$("#chatMessage").show();
				$("#message").show();
				$("#sendMessage").show();
				$("#chatMessage").html(data);
				$("#chatMessage").scrollTop($("#chatMessage")[0].scrollHeight);
				getRoomList();
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
		
		$.ajax({
			url: "chattingRoomTitle.mr",
			data: form_data,
			type: "get",		
			dataType: "html",	
			success: function(data) { 
				$("#roominfo").empty(); 
				$("#roominfo").html(data);
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
		$("#roominfo").show();	     
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
				$("#addPerson").remove();
				$("#memberinfo").empty();
				$("#roominfo").hide();
				$("#chatMessage").hide();
				$("#message").hide();
				$("#sendMessage").hide();
				$("#chattingMiddle").append(data);
			},
			error: function(request, status, error) {
				alert("code: " + request.status + "\n"+"message: " + request.responseText + "\n" + "error: " + error);     
			}
			
		});
		$("#message").hide();
		$("#sendMessage").hide();
		$("#roominfo").hide();		
	}	
	
</script>

<style type="text/css">
	#chattingDiv {
		border:2px solid #cce6ff;
	}
	
	.inChattingElement {
		border-top:1px solid #cce6ff;
		border-bottom:1px solid #cce6ff;
	}
	.chattingList {
		padding-left:10px;
		padding-right:10px;
	}
</style>

<div id="chattingDiv" style="width: 100%; height: 100%; background-color:#1f5c87; color:white;" align="center">
	<div style="float:left; width:82%; height:100%;">
		<table style="width:100%; height:100%;">
			<tr style="width:100%; height:100%;">
				<td style="width:300px; border-right:3px solid #cce6ff;">
					<div style="width:100%; height:100%; overFlow-Y:auto; overFlow-X:hidden;">
						<div class="inChattingElement" style="width:100%; height:40px; font-size: 25px;">채팅방 목록</div>
						<div class="inChattingElement" style="width:100%; font-size:20px; vertical-align:middle; padding-top:3px; cursor:pointer;" onclick="newChattingRoom()">
							<img src="<%= request.getContextPath() %>/resources/files/addchat.png" class="iconPng sideIconPng" />&nbsp;새 채팅방
						</div>
						<div style="width:100%; text-align:left;" id="room"></div>
					</div>
				</td>
				<td style="width:80%; border-right:3px solid #cce6ff; color:black;">
					<div id="chattingMiddle" style="width:100%; height:100%; background-color: #a0c0d7; overFlow-Y:auto;">
						<div class="inChattingElement chattingList" id="roominfo" style="width:100%; height:40px; background-color: #a3c3da" hidden="true"></div>
						<div class="inChattingElement chattingList" id="chatMessage" style="width:100%; min-height:90%; max-height:90%; overFlow-Y:auto;"></div>
				    	<input type="text" id="message" placeholder="메시지 내용" style="width:90%; margin-left:10px; margin-top:13px;"/>
				    	<input type="button" id="sendMessage" class="btn-info" style="margin-top:13px;" value="전송" />
				    	<input type="hidden" id="roomid" /> <!-- 보내는방 idx 저장용 -->
				    </div>
		    	</td>
			</tr>
	    </table>
    </div>
    <div id="memberinfo" style="float:left; width:18%; height:100%; color:white; overFlow-X:hidden; font-size:15px; text-align:left; padding-left:10px;">
	 	<!-- <i class="fa fa-comments"></i> -->
    </div>
</div>





