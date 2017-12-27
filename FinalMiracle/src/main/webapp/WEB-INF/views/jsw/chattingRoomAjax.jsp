<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>채팅방 정보</title>

<style type="text/css">

.notreadmessage {
	  width: 20px;
	  height: 20px;
	  border-radius:50%;
	  background-color: red;
	  padding: 5px;
	  vertical-align: middle;
	  text-align: center;
	}

</style>

</head>
<body>
	<div style="font-size: 20px;">
		<c:forEach var="room" items="${roomList}" varStatus="status">
			<div class="inChattingElement" onclick="goChatRoom(${room.cridx}); scroll();" 
						style="cursor: pointer; padding-left:20px; vertical-align: middle; padding-top:5px; padding-bottom:5px;">
				${room.roomname} 
				<span style="color:gray;">[${room.personnum}]</span>
				<c:if test="${room.notreadmessage != 0}">
					<div style="color:white; display: inline;" align="center" class="notreadmessage">${room.notreadmessage}</div>
				</c:if>
				<input type="hidden" value="${room.cridx}" id="cridx${status.count}" name="cridx${status.count}"/>
			</div>
		</c:forEach>
	</div>
</body>
</html>