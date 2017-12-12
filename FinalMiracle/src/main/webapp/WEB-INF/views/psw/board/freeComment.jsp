<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    


<script type="text/javascript">
	alert("${msg}");
	location.href="<%= request.getContextPath() %>/freeView.mr?idx=${idx}&gobackURL=${gobackURL}";       
	// 댓글쓰기를 한 원글 페이지로 이동
</script>



