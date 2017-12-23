<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<searchAllList>
	<c:forEach var="project" items="${mapOfSerchAll.projectSerchAll}">
		<project>
			<subject>${project}</subject>
		</project>
	</c:forEach>
</searchAllList>