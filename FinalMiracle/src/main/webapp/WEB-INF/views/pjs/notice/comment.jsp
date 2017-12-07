<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<hr>
<c:if test="${empty comment}">
	<tr><td colspan="2">댓글이 없습니다.</td></tr>
</c:if>
<c:if test="${not empty comment}">
	<c:forEach var="reply" items="${comment}">
		<tr>
			<td>${reply.comment}</td><td>${reply.regday}</td>
		</tr>
	</c:forEach>
</c:if>	
