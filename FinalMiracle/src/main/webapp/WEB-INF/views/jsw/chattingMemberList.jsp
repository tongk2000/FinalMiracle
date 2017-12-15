<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>대화상대</title>

<style type="text/css">


</style>

</head>
<body>
	<div style="font-size: 20px;">
		<div style="border: 1px solid red;">대화상대</div>
			<c:forEach var="member" items="${chattingMember}" varStatus="status">
				<div onclick="" style="border: 1px solid blue; cursor: pointer;"><img height="60px" width="60px" src="<%=request.getContextPath() %>/resources/images/${member.img}">
				<span style="color: black;">${member.name}</span></div>
			</c:forEach>
	</div>
</body>
</html>