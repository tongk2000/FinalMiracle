<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<books>
	<c:forEach var="fcvo" items="${folder_commentList}">
		<book>
			<subject>${fcvo.userid}</subject>
			<author>${fcvo.content}</author>
			<writedate>${fcvo.writeDate}</writedate>
		</book>
	</c:forEach>
</books>




