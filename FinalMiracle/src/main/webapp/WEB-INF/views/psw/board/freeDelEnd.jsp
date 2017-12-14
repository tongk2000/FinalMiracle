<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<script type="text/javascript">

	<c:if test="${result == 1}">  // Controller에서 받아온 "result"값이 1이면 글삭제 성공 -> 전체글목록보기 이동(freeList.mr)
		alert("게시글 삭제 성공 ~");
		location.href="<%= request.getContextPath() %>/freeList.mr";       
	</c:if>
	
	<c:if test="${result != 1}">  // Controller에서 받아온 "result"값이 1이 아니면 글삭제 실패 -> 이전페이지 이동(back();)
		alert("게시글 삭제 오류 ...");
		javascript:history.back();
		// 이전 페이지로 이동
	</c:if>
		
</script>




