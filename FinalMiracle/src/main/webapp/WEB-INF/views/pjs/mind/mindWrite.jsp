<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 글</title>
<style>
	img {
		width:25px;
		height:25px;
	}
</style>
</head>
<body>
<c:set var="user" value="${map}" />  <!-- teamNum , userid , teamNum , memberNum, status -->
	<div style="border: 1px solid green; width:100%;">
		<div style="border: 1px solid yellow;">
			<table style="border: 1px solid red; width: 80%;">
				<thead>
					<tr>
						<th colspan="2">마음의 소리</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td width="12%">유저 아이디 : </td><td><img src="<%= request.getContextPath() %>/resources/images/${user.img}" class="img"> &nbsp;&nbsp; ${user.userid}</td>
					</tr>
					<tr>
						<td width="12%">팀정보 : </td><td>${user.teamNum}</td>
					</tr>
					<tr>
						<td width="12%">제목 : </td>
						<td><input id="subject" type="text"/></td>
					</tr>
					<tr style="min-height: 200px;">
						<td>내용 :</td>
						<td height="200px"><input id="content" name="content" style="min-height:250px; min-width:400px;"/></td>
					</tr>
				</tbody>
			</table>
			<div style="display:block; float:right;"><button type="button" onClick="writeEnd();">완료</button></div>
		</div>
	</div>
	<form name="end">
		<input type="hidden" name="userid">
		<input type="hidden" name="teamNum">
		<input type="hidden" name="subject">
		<input type="hidden" name="content">
		<input type="hidden" name="nidx">
		<input type="hidden" name="chkid">
	</form>
	<script>
		function writeEnd() {
			var frm = document.end;
			var subject = $("#subject").val();
			var content = $("#content").val();
			var nidx = "${nidx}";
			frm.nidx.value = nidx;
			if(nidx == null || nidx=="") { // 일반글쓰기
				frm.userid.value = "${user.userid}";
			}
			if(nidx!=null && nidx!=""){ // 답변글쓰기
				frm.userid.value = "${sessionScope.loginUser.userid}";
				frm.chkid.value = "${chkid}";
			}
			frm.teamNum.value = "${user.teamNum}";
			frm.subject.value = subject;
			frm.content.value = content;
			frm.action="<%=request.getContextPath()%>/mindWriteEnd.mr";
			frm.method="post";
			frm.submit();
		}
	</script>
</body>
</html>