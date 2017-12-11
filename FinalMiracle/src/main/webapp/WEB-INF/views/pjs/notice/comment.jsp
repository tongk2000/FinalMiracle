<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
%>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%--
<hr> 
<c:if test="${empty comment}">
	<tr><td colspan="2">댓글이 없습니다.</td></tr>
</c:if>
<c:if test="${not empty comment}">
	<c:forEach var="reply" items="${comment}">
		<tr>
			<td>${reply.reply_content}</td><td>${reply.regday}</td>
		</tr>
	</c:forEach>
</c:if>	 
--%>
<table>
	<thead>
		<tr>
			<th class="first">작성자</th><th class="second">댓글</th><th class="third">작성일</th>
		</tr>
	</thead>
	<tbody>
		<c:if test="${empty comment}" >
				<tr>
					<td colspan="3">댓글이 없습니다.</td>
				</tr>
		</c:if>
		<c:if test="${not empty comment}" >
			<c:forEach var="reply" items="${comment}">
				<tr class="lastComment">
					<td class="first">${sessionid}</td><td class="second">${reply.reply_content}</td><td class="third">${reply.regday}</td>
				</tr>
			</c:forEach>
		</c:if>
	</tbody>
</table>