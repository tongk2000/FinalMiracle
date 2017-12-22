<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div>
	<c:forEach var="project" items="${mapOfSerchAll.projectSerchAll}">
		<span>${project}</span><br/>
	</c:forEach>
</div>
















