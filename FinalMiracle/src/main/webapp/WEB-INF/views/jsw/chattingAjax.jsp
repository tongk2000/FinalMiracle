<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style type="text/css">
	
	

</style>

<script type="text/javascript">
	
	$(document).ready(function(){
		
	var form_data = {name : $("#name").val()		//  키값 : 벨류값
			//	,gender : $("#gender").val()	//  키값 : 벨류값
			//	,age : $("#age").val()			//  키값 : 벨류값
				};
	
	$.ajax({
		url: "ajaxstudymemberInfo.do",
		type: "get",
		data: form_data,	// 위의 url주소로 보내어질 요청대이터이다
		dataType: "html",	// ajax 요청에의해 url주소(ajaxstudymemberInfo.do)로 리턴받는 데이터 타입이다
		 					// 종류가 xml, json, html, script, text
		success: function(data) { // success => url주소(ajaxstudymemberInfo.do)로 부터 받은 응답이 요청에 성공했다는 것을 말한다
									// function(data) {}를 콜백함수라고 부르는데 성공한 다음에 실행할것들을 여기에 서술한다
									// 그리고 data는 url주소(ajaxstudymemberInfo.do)로부터 리턴받은 데이터이다
			$("#memberInfo").empty(); // 해당요소 선택자 내용을 모두 비워서 새로운 데이터를 채울 준비를 한다
			$("#memberInfo").html(data);
		},
		error: function(request, status, error) {
			alert("code: " + request.status + "\n"+"message: " + request.responseText + "\n" + "error: " + error);     
			/*
				== request.status 의 종류 == 
				---------------------------------------------
				status 값	의미						설명
				---------------------------------------------
				200  		ok						요청성공 
				403 		fobidden 				접근금지
				404 		Not Found				페이지 없음
				500 		internal Server Error	서버에러발생
			*/
		}
	});
		
	});
	
	function goChatRoom() {
		
	}
	
	
	
</script>


<div style="float: left; width: 200px; height: 500px; border: 1px solid red;">

	채팅방 목록
		<div style="border: 1px solid yellow;">
			<c:forEach var="room" items="${roomList}">
				<div onclick="goChatRoom()">${room.roomname} <span style="color: gray;">[${room.personnum}]</span>
					<c:if test="${room.notreadmessage != 0}">
						<span style="background-color: red;">${room.notreadmessage}</span>
					</c:if>
				</div>
			</c:forEach>
			
			<div>채팅방 이름 <span style="color: gray;">[5]</span></div>
		</div>
	</div>
	<div style="float: left;">
	<div id="chatMessage" style="overFlow: auto; height: 500px; border: 1px solid blue; width: 600px;"></div>
    <div id="chatStatus"></div>
    <input type="text" id="message" placeholder="메시지 내용"/>
    <input type="button" id="sendMessage" value="전송" />
    <input type="hidden" id="to" placeholder="귓속말대상"/>
    </div>

