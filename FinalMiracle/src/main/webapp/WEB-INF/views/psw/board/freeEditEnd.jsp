<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<script type="text/javascript">
	<c:if test="${result == 1}">  // Controller에서 "result"값이 1이라면 글수정 성공. DB update 성공.
		alert("글 수정 성공!!");
		location.href="<%= request.getContextPath() %>/freeView.mr?idx=${idx}";       
		// 수정된 자신의 글을 보여주는 페이지로 이동
	</c:if>
	
	<c:if test="${result != 1}">  // Controller에서 "result"값이 0이라면 글수정 실패. DB update 실패. 이전 페이지로 복귀.
		alert("글 수정 실패!!");
		history.back();
		// 이전 페이지로 이동
	</c:if>
</script>




