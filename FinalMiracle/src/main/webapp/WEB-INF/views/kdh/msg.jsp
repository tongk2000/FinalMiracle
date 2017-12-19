<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">
	window.onload = function() {
		alert("${msg}");
		var frm = document.pageDateFrm;
		frm.action = "doList.mr";
		frm.submit();
	}
</script>
<form name="pageDateFrm">
	<input type="hidden" name="term" value="${term}"/>
	<input type="hidden" name="page" value="${page}"/>
</form>