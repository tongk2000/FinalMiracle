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
</style>
</head>
<body>
<c:set var="user" value="${map}" /> 
<c:set var="reply" value="${comment}" />
	<div>
		<div style="align: center;">
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
			댓글 :&nbsp;&nbsp;<input type="text" /> <button type="button" id="goClick();">쓰기</button>
			<div id="displayList" style="background-color:white;"></div>
		</div>
	</div>
	<!-- comment(ReplyVO), map(team_idx , userid) 받는다. -->
	<script>
		$(document).ready(function(){
			<c:if test="${not empty comment}">
				$("#displayList").show();
			</c:if>
		});
		function goClick(idx) {
			alert("여기 옴?");
			$.ajax({
				url:"noticeReply.mr",
				type:"get",
				data:{"idx":idx},
				dataType:"html",
				success:function(data){
					if(data.length>0) {
						$("#displayList").html(data);
						$("#displayList").show();
					}
					else {
						alert("ajax결과"+data);
					}
				},
				error:function(){
				}
			});
		}
	</script>
</body>
</html>