<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<script type="text/javascript">
	
	<c:if test="${n == 1}">
		alert("메모를 작성하였습니다.");
		location.href="<%= request.getContextPath() %>/memoList.mr";
	</c:if>
	
	<c:if test="${n != 1}">
		alert("메모 작성에 실패하였습니다.");
		location.href="<%= request.getContextPath() %>/memoList.mr";
	</c:if>

	
</script>