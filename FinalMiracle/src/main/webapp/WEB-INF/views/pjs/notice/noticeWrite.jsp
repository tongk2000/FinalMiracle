<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/jqueryuicss/jquery-ui.css" />
<link href="<%=request.getContextPath() %>/resources/summernote/summernote.css" rel="stylesheet">
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/jqueryuijs/jquery-ui.js"></script>
<script src="<%=request.getContextPath() %>/resources/summernote/summernote.js"></script>
<script src="<%=request.getContextPath() %>/resources/summernote/lang/summernote-ko-KR.js"></script>
<!DOCTYPE>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 글</title>
<style>
	/* img {
		width:25px;
		height:25px;
	} */
	#chk {
		position:absolute;
	}
</style>
</head>
<body>
<c:set var="user" value="${map}" />  <!-- teamNum , userid , teamNum , memberNum, status -->
	<div> <!-- style="width:700px; float:right;" -->
		 <div style="border: 0px solid yellow; " align="center"> <!-- width:500px; -->
			<div style=" border:3px solid #337ab7; "> <!-- width:500px; -->
			 <span style="color:red"> 공지사항 글 </span><br/>
			 <span style="color:lightblue;">팀 프로젝트 중요사항 입니다.</span>
			</div><br/>
			<form name="writeFrm" enctype="multipart/form-data">
			<table style="border: 0px solid black; width: 80%;" id="tb">
				<thead>
					<tr style="text-align:right; border-bottom:1px solid lightgray;">
						<th colspan="2" style="text-align:center; color:lightgray; font_size:30px; margin-bottom:30px;">공지 글쓰기</th>
					</tr>
				</thead>
				<tbody>
					<tr style="border-top:1px solid lightgray; border-bottom:1px solid lightgray; "> 
						<td width="12%" style="text-align:center;">유저 아이디 </td>
						<td ><img src="<%= request.getContextPath() %>/resources/images/${user.img}" style="width:100px; width:100px; height:100px; padding-left:10px;"> &nbsp;&nbsp;<input type="hidden" name="userid" value="${user.userid}">${user.userid} 님</td>
					</tr>
					<tr>
						<td width="12%" style="border-left:1px solid lightgray; border-right:1px solid lightgray; text-align:center;">팀정보  </td><td style="border-right:1px solid lightgray; padding-left:10px;"><input type="hidden" name="teamNum" value="${user.teamNum}">${user.teamNum} 팀<input type="hidden" name="idx" value="${idx}"></td>
					</tr>
					<tr>
						<td width="12%" style="border-left:1px solid lightgray; text-align:center;">제목  </td>
						<td style="border-left:1px solid lightgray; border-right:1px solid lightgray; padding-left:10px;"><input id="subject" type="text" name="subject"/></td>
					</tr>
					<tr style="min-height: 200px;">
						<td style="border-left:1px solid lightgray; text-align:center;">내용 </td>
						<td height="200px" style="border-left:1px solid lightgray; border-right:1px solid lightgray;"><textarea name="content" id="content" class="summernote"></textarea></td>
					</tr>
					<tr style="1px solid lightgary;">
					   <td style="border-left:1px solid lightgray; border-bottom:1px solid lightgray; text-align:center;">파일첨부</td>
					   <td style="border-left:1px solid lightgray; border-bottom:1px solid lightgray; border-right:1px solid lightgray; padding-left:10px;"><input type="file" name="attach" /></td>
					</tr>
				</tbody>
			</table>
			</form>
			<div style="display:inline; float:right;"><button type="button" onClick="goWrite();" id="chk">완료</button></div>
			<div style="display:inline; float:right;"><button type="button" onClick="goback();" id="chk">목록보기</button></div>
		</div>
	</div>
	<!-- <form name="end">
		<input type="hidden" name="idx">
		<input type="hidden" name="userid">
		<input type="hidden" name="teamNum">
		<input type="hidden" name="subject">
		<input type="hidden" name="content">
	</form> -->
	<script>
		function goWrite() {
			// 유효성 검사는 생략 하겠음.
			var frm = document.writeFrm;
			frm.action="<%=request.getContextPath()%>/noticeWriteEnd.mr";
			frm.method="post";
			frm.submit();
			
		}

		function writeEnd() {
			/* var frm = document.end;
			var subject = $("#subject").val();
			var content = $("#content").val();
			frm.userid.value = "${user.userid}";
			frm.teamNum.value = "${user.teamNum}";
			frm.subject.value = subject;
			frm.content.value = content;
			 */
		}
		function goback() {
			location.href="<%=request.getContextPath()%>/${gobackURL}";
		}
		$(document).ready(function(){
			$('.summernote').summernote({
		      height: 300,          // 기본 높이값
		      minHeight: null,      // 최소 높이값(null은 제한 없음)
		      maxHeight: null,      // 최대 높이값(null은 제한 없음)
		      focus: true,          // 페이지가 열릴때 포커스를 지정함
		      lang: 'ko-KR'         // 한국어 지정(기본값은 en-US)
		    });
			
			var left = $("#tb").position().left+930;  // 테이블 기준 , 글쓰기/삭제버튼 위치조정
			var bottom = $("#tb").position().bottom+10;
			$("#chk").css({"left":left+"px", "bottom":bottom+"px"}); 
		});
	</script>
</body>
</html>