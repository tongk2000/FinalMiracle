<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 글</title>
<style>
	.img {
		width:25px;
		heigth:25px;
	}
	div#displayList {
		width:80%;
		border : 1px solid black;
		align:center;
	}
	.first {
		width:15%;
	}
	.second {
		width:65%;
	}
	.third {
		width:20%;
	}
	tr, th, td {
		border:1px solid red;
	}
	
</style>
</head>
<body>
<c:set var="user" value="${map}" /> <!-- teamNum , userid , teamNum , status -->
	<div style="border: 1px solid green; width:100%;">
		<div style="border: 1px solid yellow;">
			<table style="border: 1px solid red; width: 80%;">
				<thead>
					<tr>
						<th colspan="2">공지글</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td width="12%">유저 아이디 : </td><td><img src="<%= request.getContextPath() %>/resources/images/${user.img}" class="img"> &nbsp;&nbsp; ${user.userid}</td>
					</tr>
					<tr>
						<td width="12%">팀정보 : </td><td>${user.team_idx}</td>
					</tr>
					<tr>
						<td width="12%">제목 :</td>
						<td><input type="text" value="${user.subject}" readonly /></td>
					</tr>
					<tr style="min-height: 200px;">
						<td>내용 :</td>
						<td height="200px">${user.content}</td>
					</tr>
				</tbody>
			</table>
			<c:if test="${sessionScope.teamInfo.teamwon_status == 2}">
				<div style="float:left;" >
					<button type="button" onClick="goEdit();">수정글쓰기</button>
				</div>
			</c:if>
			<br/>
			<br/>
			<div id="displayList" style="background-color:white; align:center;"> </div>
			<br/>
			<div style="align:center;">댓글 :&nbsp;&nbsp;<input type="text" id="contents" name="contents"/> <button type="button" id="goClick">쓰기</button></div> <br/><br/>
		</div>
	</div>
	<form name="edit">
		<input type="hidden" name="nidx">
		<input type="hidden" name="userid">
		<input type="hidden" name="teamNum">
	</form>
	<!-- comment(ReplyVO), map(team_idx , userid) 받는다. -->
	<script>
		$(document).ready(function(){
			alert("옴?");
			alert("${user.status}");
			getReply();
			$("#goClick").click(function(){
				var contents = $("#contents").val();
				var nidx = "${nidx}";
				goClick(nidx,contents);
			});
		});
		function getReply() {
			var data_form = {"nidx":"${nidx}"};
			$.ajax({
				url:"getnoticeReplyList.mr",
				type:"get",
				data:data_form,
				dataType:"html",
				success:function(data) {
					alert(data);
					$("#displayList").html(data);
				},
				error:function() {
					alert("getReply 실패");
				}
			});
		}
		function goClick(idx, contents) {
			$.ajax({
				url:"setnoticeReplyList.mr",
				type:"post",
				data:{"idx":idx,"contents":contents}
			});
			getReply();				
		}
		function goEdit() {
			var frm = document.edit;
			frm.nidx.value="${nidx}";
			frm.userid.value="${sessionScope.loginUser.userid}";
			frm.teamNum.value="${user.team_idx}";
			frm.action="<%=request.getContextPath()%>/noticeEditWrite.mr";
			frm.method="get";
			frm.submit();
		}
	</script>
</body>
</html>