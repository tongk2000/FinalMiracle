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
		width:70%;
	}
	.third {
		width:15%;
	}
	th, td {
		text-align:center;
	}
</style>
</head>
<body>
<c:set var="user" value="${map}" /> 
	<div align="center">
		<div >
			<table>
				<thead>
					<tr>
						<th colspan="2">공지글</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>유저 아이디 :</td>
						<td><img src="<%= request.getContextPath() %>/resources/images/${user.img}" class="img"> ${user.userid} 팀정보 : ${user.team_idx}</td>
					</tr>
					<tr>
						<td>제목 :</td>
						<td><input type="text" value="${user.subject}"/></td>
					</tr>
					<tr>
						<td>내용 :</td>
						<td><textarea>${user.content}</textarea></td>
					</tr>
				</tbody>
			</table>
			<div style="align:center;">댓글 :&nbsp;&nbsp;<input type="text" id="contents" name="contents"/> <button type="button" id="goClick">쓰기</button></div> <br/><br/>
			<div id="displayList" style="background-color:white; align:center;"> </div>
		</div>
	</div>
	<!-- comment(ReplyVO), map(team_idx , userid) 받는다. -->
	<script>
		$(document).ready(function(){
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
			alert("여기 옴?");
			alert(idx);
			alert(contents);
			$.ajax({
				url:"setnoticeReplyList.mr",
				type:"post",
				data:{"idx":idx,"contents":contents}
			});
			getReply();				
		}
	</script>
</body>
</html>