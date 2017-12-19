<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
%>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/jqueryuicss/jquery-ui.css" />
<link href="<%=request.getContextPath() %>/resources/summernote/summernote.css" rel="stylesheet">
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/jqueryuijs/jquery-ui.js"></script>
<script src="<%=request.getContextPath() %>/resources/summernote/summernote.js"></script>
<script src="<%=request.getContextPath() %>/resources/summernote/lang/summernote-ko-KR.js"></script>
<!DOCTYPE>
<html>
<head>
<meta charset="UTF-8">
<title>마음의 소리 글</title>
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
			<form name="end" enctype="multipart/form-data"> 
			<table style="border: 1px solid red; width: 80%;">
				<thead>
					<tr>
						<th colspan="2">마음의 소리</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td width="12%">유저 아이디 : </td><td><img src="<%= request.getContextPath() %>/resources/images/${user.img}" class="img"> &nbsp;&nbsp; ${user.userid}
						<input type="hidden" name="userid" value="${user.userid}"></td>
					</tr>
					<tr>
						<td width="12%">팀정보 : </td><td>${user.teamNum}<input type="hidden" name="teamNum" value="${user.teamNum}"></td>
					</tr>
					<tr>
						<td width="12%">제목 : </td>
						<td><input id="subject" type="text" name="subject" value="${user.subject}"/><input type="hidden" name="nidx" value="${user.nidx}"></td>
					</tr>
					<tr style="min-height: 200px;">
						<td>내용 :</td>
						<td height="200px"><textarea name="content" id="content" class="summernote">${user.content}</textarea>
						<input type="hidden" name="chkid"><input type="hidden" name="idx" value="${didx}"></td>
					</tr>
					<tr>
					   <td>파일첨부</td>
					   <td><input type="file" name="attach" /></td>
					</tr>
				</tbody>
			</table>
			</form>
			<div style="display:block; float:right;"><button type="button" onClick="writeEnd();">완료</button></div>
		</div>
	</div>
	<!-- <form name="end" enctype="multipart/form-data"> 
		<input type="hidden" name="content">
		<input type="hidden" name="nidx">
	</form> -->
	<script>
		function writeEnd() {
			var frm = document.end; 
			alert("오니");// nidx, subject, content ,userid, teanNum
			/* var subject = $("#subject").val();
			var content = $("#content").val();
			var nidx = "${nidx}"; //? 뭐냐?
			var idx = "${didx}"; 
			frm.nidx.value = nidx;
			if(nidx == null || nidx=="") { // 일반글쓰기
				frm.userid.value = "${user.userid}";
			}
			if(nidx!=null && nidx!=""){ // 답변글쓰기
				frm.userid.value = "${sessionScope.loginUser.userid}";
				frm.chkid.value = "${chkid}";
			} */
			/* frm.teamNum.value = "${user.teamNum}";
			frm.subject.value = subject;
			frm.content.value = content;
			frm.attach.value = $("#attach").val(); */
			
			frm.action="<%=request.getContextPath()%>/mindViewEditEnd.mr";
			frm.method="post";
			frm.submit();
		}
		$(document).ready(function(){
			$('.summernote').summernote({
		      height: 300,          // 기본 높이값
		      minHeight: null,      // 최소 높이값(null은 제한 없음)
		      maxHeight: null,      // 최대 높이값(null은 제한 없음)
		      focus: true,          // 페이지가 열릴때 포커스를 지정함
		      lang: 'ko-KR'         // 한국어 지정(기본값은 en-US)
		    });
		});
	</script>
</body>
</html>