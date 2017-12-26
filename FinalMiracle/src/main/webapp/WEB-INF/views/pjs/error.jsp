<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
%>

<script type="text/javascript">
	var msg = "${msg}";
	alert(msg);
	${loc};
</script>