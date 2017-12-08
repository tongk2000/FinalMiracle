<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style type="text/css">
	
	

</style>

<script type="text/javascript">
	
	$(document).ready(function(){

	
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

