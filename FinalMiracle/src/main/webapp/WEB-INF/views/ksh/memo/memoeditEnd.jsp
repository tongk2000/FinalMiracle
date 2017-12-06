<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<script type="text/javascript">
	
	<c:if test="${n == 1}">
		alert("메모를 수정하였습니다.");
		location.href="<%= request.getContextPath() %>/${gobackURL}";
	</c:if>
	
	<c:if test="${n != 1}">
		alert("메모 수정에 실패하였습니다.");
		location.href="<%= request.getContextPath() %>/${gobackURL}";
	</c:if>

	
</script>