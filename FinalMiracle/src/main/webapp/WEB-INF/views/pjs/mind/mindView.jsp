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
<title>마음의 소리</title>
<!DOCTYPE>
<html>
<head>
<meta charset="UTF-8">
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
<c:set var="user" value="${map}" /> <!-- userid , teamNum , status -->
	<div style="border: 1px solid green; width:100%;">
		<div style="border: 1px solid yellow;">
			<table style="border: 1px solid red; width: 80%;">
				<thead>
					<tr>
						<th colspan="2">익명글</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<c:if test="${user.status == 2 || sessionScope.loginUser.userid == user.userid}">
							<td width="12%">유저 아이디 : </td><td><img src="<%= request.getContextPath() %>/resources/images/${user.img}" class="img"> &nbsp;&nbsp; ${user.userid}</td>
						</c:if>
						<c:if test="${user.status == 1 && sessionScope.loginUser.userid != user.userid}">
							<td width="12%">익명의 유저 : </td><td><img src="<%= request.getContextPath() %>/resources/images/${defaultimg2.img}" class="img"> &nbsp;&nbsp;</td>
						</c:if>
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
						<td height="200px"><textarea name="content" id="content" class="summernote">${user.content}</textarea></td>
					</tr>
				</tbody>
			</table>
			<c:if test="${sessionScope.teamInfo.teamwon_status == 2}">
				<div style="float:left;" >
					<button type="button" onClick="goEdit();">답변글쓰기</button>
				</div>
			</c:if>
			<br/>
			<br/>
			<div id="displayList" style="background-color:white; align:center;"> </div>
			<br/>
		</div>
	</div>
	<form name="edit">
		<input type="hidden" name="nidx">
		<input type="hidden" name="userid">
		<input type="hidden" name="teamNum">
		<input type="hidden" name="chkid">
	</form>
	<!-- comment(ReplyVO), map(team_idx , userid) 받는다. -->
	<script>
		$(document).ready(function(){
			$("#goClick").click(function(){
				var contents = $("#contents").val();
				var nidx = "${nidx}";
				goClick(nidx,contents);
			});
			$('.summernote').summernote({
			      height: 300,          // 기본 높이값
			      minHeight: null,      // 최소 높이값(null은 제한 없음)
			      maxHeight: null,      // 최대 높이값(null은 제한 없음)
			      focus: true,          // 페이지가 열릴때 포커스를 지정함
			      lang: 'ko-KR'         // 한국어 지정(기본값은 en-US)
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
			frm.nidx.value="${didx}";
			frm.userid.value="${sessionScope.loginUser.userid}";
			frm.chkid.value="${user.userid}";
			frm.teamNum.value="${user.team_idx}";
			frm.action="<%=request.getContextPath()%>/mindReplyWrite.mr";
			frm.method="get";
			frm.submit();
		}
	</script>
</body>
</html>