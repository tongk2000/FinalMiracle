<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>

<style type="text/css">


</style>

</head>
<body>
	
		<c:forEach var="list" items="${chattingList}" varStatus="status">
			<c:if test="${list.midx == sessionScope.loginUser.idx}">
				<div onclick="" style="border: 1px solid blue; cursor: pointer; float: right;"><img height="30px" width="30px" src="<%=request.getContextPath() %>/resources/images/${list.img}"></div>
				<div style="float: right;" id="chat${status.count}"><span style="color: black;">${list.name}</span></div><br/>
				<div style="float: right;"><span style="color: gray; font-size: xx-small;">${list.chattime}</span> ${list.message}</div><br/>
			</c:if>
			<c:if test="${list.midx != sessionScope.loginUser.idx}">
				<div onclick="" style="border: 1px solid blue; cursor: pointer; float: left;"><img height="30px" width="30px" src="<%=request.getContextPath() %>/resources/images/${list.img}"></div>
				<div><span style="color: black;" id="chat${status.count}">${list.name}</span></div>
				<div>${list.message} <span style="color: gray; font-size: xx-small;">${list.chattime}</span></div>
			</c:if>
			<c:set var="divcount" value="${status.count}" scope="session" />
			<%-- ${status.count} --%>
		</c:forEach>
	

</body>
</html>