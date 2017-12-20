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
				<div onclick="" style="border: 0px solid blue; cursor: pointer; float: right; margin-right: 10px;"><img style="border: 0px solid blue;" class="img-circle" height="35px" width="35px" src="<%=request.getContextPath() %>/resources/images/${list.img}"></div>
				<%-- <div style="float: right;" id="chat${status.count}"><span style="color: black;">${list.name}</span></div> --%><span style="float: right;">나</span><br/>
				<div style="float: right;"><span style="color: gray; font-size: xx-small;">${list.chattime}</span> <span>${list.message}</span></div><br/>
			</c:if>
			<c:if test="${list.midx != sessionScope.loginUser.idx}">
				<div onclick="" style="border: 0px solid blue; cursor: pointer; float: left;"><img style="border: 0px solid blue;" class="img-circle" height="35px" width="35px" src="<%=request.getContextPath() %>/resources/images/${list.img}"></div>
				<div><span style="color: black; float: left;" id="chat${status.count}">${list.name}</span></div><br/>
				<div style="float: left;"><span class="otherchat">${list.message}</span> <span style="color: gray; font-size: xx-small;">${list.chattime}</span></div><br/>
			</c:if>
		</c:forEach>
	

</body>
</html>