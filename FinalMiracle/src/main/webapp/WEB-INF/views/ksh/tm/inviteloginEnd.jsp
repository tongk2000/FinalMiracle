<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">

	<c:if test="${m > 0}">
		alert("초대가 완료되었습니다.");
		location.href="<%= request.getContextPath() %>/tmForm.mr";
	</c:if>
	
	<c:if test="${m == 0}">
		alert("정상적으로 초대가 완료되지 못했습니다.");
		javascript:history.back();
	</c:if>

</script>