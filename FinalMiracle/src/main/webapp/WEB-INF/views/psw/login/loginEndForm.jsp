<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">

	<c:if test="${n == 1 && empty gobackURL}">
		alert("로그인 성공 !!");
		location.href="<%= request.getContextPath() %>/index.mr";
	</c:if>
	
	<c:if test="${n == 1 && not empty gobackURL}">
		alert("로그인 성공 !!");
		location.href="${gobackURL}";
	</c:if>
	
	<c:if test="${n == 0}">
		alert("암호 가 틀렸습니다.");
		javascript:history.back();
	</c:if>
		
	<c:if test="${n == -1}">
		alert("아이디가 없습니다.");
		javascript:history.back();
	</c:if>

</script>