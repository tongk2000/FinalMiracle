<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<table>
	<tbody>
		<c:if test="${not empty comment}">
			<c:forEach var="reply" items="${comment}">
				<tr>
					<td>${reply.comment}</td><td>${reply.regday}</td>
				</tr>
			</c:forEach>
		</c:if>	
	</tbody>
</table>