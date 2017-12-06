<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">

	<c:if test="${n > 0}">
		alert("팀이 생성되었습니다.");
		location.href="<%= request.getContextPath() %>/tmForm.mr";
	</c:if>
	
	<c:if test="${n == 0}">
		alert("팀이 정상적으로 생성되지 못했습니다.");
		javascript:history.back();
	</c:if>

</script>