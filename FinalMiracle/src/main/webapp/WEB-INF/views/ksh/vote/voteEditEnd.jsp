<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
	
	<c:if test="${x == 1 && n == 1}">
		alert("투표를 수정하였습니다.");
		location.href="<%= request.getContextPath() %>/voteReadyList.mr";
	</c:if>
	
	<c:if test="${x != 1}">
		alert("투표글이 전부 작성되지 않았습니다.");
		location.href="<%= request.getContextPath() %>/voteReadyList.mr";
	</c:if>
	
	<c:if test="${n != 1}">
		alert("투표의 문항들을 확인하세요.");
		location.href="<%= request.getContextPath() %>/voteReadyList.mr";
	</c:if>

	
</script>