<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<myElementOn>
	<c:forEach var="idx" items="${map.myElementList}">
		<idx>${idx}</idx>
	</c:forEach>
	<before>${map.periodCntMap.before}</before>
	<doing>${map.periodCntMap.doing}</doing>
	<lapse>${map.periodCntMap.lapse}</lapse>
	<complete>${map.periodCntMap.complete}</complete>
</myElementOn>


