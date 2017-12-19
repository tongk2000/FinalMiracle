<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
%>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%--
<hr> 
<c:if test="${empty comment}">
	<tr><td colspan="2">댓글이 없습니다.</td></tr>
</c:if>
<c:if test="${not empty comment}">
	<c:forEach var="reply" items="${comment}">
		<tr>
			<td>${reply.reply_content}</td><td>${reply.regday}</td>
		</tr>
	</c:forEach>
</c:if>	 
--%>
<style>
	img {
		width:25px;
		height:25px;
	}
	.noticewrite {
		background-color:lightgray;
		text-align:center;
	}
	.noticenone {
		background-color:white; border:0px;
	}
	.pjstdstyle {
		border:0px;
		text-align:center;
	}
</style>
<script type="text/javascript">
	window.onload = function() {
	 alert("여기 오냐?");
	}
	function gourl(pageNo) {
		alert(pageNo);
		data_form = {"idx":"${idx}",
				     "currentShowPageNo":pageNo
				     };
		$.ajax({ 
			url:"getnoticeReplyListajax.mr",
			type:"get",
			data:data_form,
			dataType:"html",
			success:function(data) {
				$("#displayList").html(data);
			},
			error:function() {
				alert("getReply 실패");
			}
		});
	}
</script>
<table style="width:800px; border:0px; text-align:center;" class="noticetable">
	<thead style="">
		<tr class="noticetable" style="border-bottom:0px; text-align:center;">
			<th class="noticewrite"></th>
			<th class="noticewrite">작성자</th>
			<th class="noticewrite">댓글</th>
			<th class="noticewrite">작성일</th>
		</tr>
	</thead>
	<tbody>
		<c:if test="${pvo == null}" >
				<tr style="border:0px white;">
					<td colspan="4" style="text-align:center; border:0px white;">댓글이 없습니다.</td>
				</tr>
		</c:if>
		<c:if test="${pvo != null}" >
			<c:forEach var="reply" items="${pvo.comment}">
				<tr class="lastComment">
					<td class="noticenone pjstdstyle"><img src="<%=request.getContextPath() %>/resources/images/${reply.img}" ></td>
					<td class="pjstdstyle">${reply.sesid}</td>
					<td class="pjstdstyle" style="text-align:left; padding-left:20px;">${reply.reply_content}</td>
					<td class="pjstdstyle">${reply.regday}</td>
				</tr>
			</c:forEach>
		</c:if>
	</tbody>
</table>

<%-- <form name="page">
	<input type="hidden" name="sizePerPage" value="${pvo.sizePerPage}" />
	<input type="hidden" name="blockSize" value="${pvo.blockSize}" />
</form> --%>
<div align="center">
	${pvo.pagebar}
</div>