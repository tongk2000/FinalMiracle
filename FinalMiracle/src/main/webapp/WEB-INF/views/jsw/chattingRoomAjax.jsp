<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>채팅방 정보</title>

<style type="text/css">


</style>

</head>
<body>
	<div style="font-size: 20px;">
		<c:forEach var="room" items="${roomList}" varStatus="status">
			<div onclick="goChatRoom(${room.cridx}); scroll();" style="border-bottom: 1px solid white; cursor: pointer; vertical-align: middle; padding: 5px; padding-left: 20px;">${room.roomname} <span style="color: gray;">[${room.personnum}]</span>
				<c:if test="${room.notreadmessage != 0}">
					<span style="background-color: red; color: white;">${room.notreadmessage}</span>
				</c:if>
				<input type="hidden" value="${room.cridx}" id="cridx${status.count}" name="cridx${status.count}"/>
			</div>
		</c:forEach>
	</div>
</body>
</html>