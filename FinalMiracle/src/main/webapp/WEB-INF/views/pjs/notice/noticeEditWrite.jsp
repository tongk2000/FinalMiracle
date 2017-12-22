<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
%>    
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/jqueryuicss/jquery-ui.css" />
<link href="<%=request.getContextPath() %>/resources/summernote/summernote.css" rel="stylesheet">
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/jqueryuijs/jquery-ui.js"></script>
<script src="<%=request.getContextPath() %>/resources/summernote/summernote.js"></script>
<script src="<%=request.getContextPath() %>/resources/summernote/lang/summernote-ko-KR.js"></script>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 글</title>
<style>
	/* img {
		width:25px;
		heigth:25px;
	} */
	#end {
		position : absolute;	
	}
	.pjspadding {
		padding:3px;
	}
</style>
</head>
<body>
<c:set var="user" value="${map}" />  <!-- nidx, userid, teamNum --> 
	<div style="border: 0px solid green; width:100%;" align="center">
		<div style="border: 0px solid yellow; padding-top:20px;">
			<table style="border: 0px solid red; width: 80%;" id="tb">
				<thead>
					<tr>
						<th class="pjspadding" colspan="2" style="text-align:center; border-bottom:1px solid lightgray; padding-bottom:10px;">수정공지글</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td class="pjspadding" width="12%" style="border-bottom:1px solid lightgray;"><img src="<%= request.getContextPath() %>/resources/images/${user.img}" class="img" style="width:100px; heigth:100px;"></td><td class="pjspadding" style="border-bottom:1px solid lightgray;"> &nbsp;&nbsp; ${user.userid} 님</td>
					</tr>
					<tr>
						<td  class="pjspadding" width="12%" style="border-left:1px solid lightgray; text-align:center;">팀정보  </td><td class="pjspadding" style="border-right:1px solid lightgray;"> ${user.teamNum}</td>
					</tr>
					<tr>
						<td width="12%" class="pjspadding" style="border-left:1px solid lightgray; text-align:center;"> 제목  </td>
						<td style="border-right:1px solid lightgray;"><input id="subject" type="text" class="pjspadding" /></td>
					</tr>
					<tr style="min-height: 200px;">
						<td class="pjspadding" style="border-left:1px solid lightgray; border-bottom:1px solid lightgray; text-align:center;"> 내용 </td>
						<td height="200px" style="border-bottom:1px solid lightgray; border-right:1px solid lightgray;"><textarea name="content" id="content" class="summernote" ></textarea></td>
					</tr>
				</tbody>
			</table>
			<div id="end"><button type="button" onClick="writeEnd();">완료</button></div>
		</div>
	</div>
	<form name="end">
		<input type="hidden" name="userid">
		<input type="hidden" name="teamNum">
		<input type="hidden" name="subject">
		<input type="hidden" name="content">
		<input type="hidden" name="nidx">
	</form>
	<script>
		function writeEnd() {
			var frm = document.end;
			var subject = $("#subject").val();
			var content = $("#content").val();
			frm.nidx.value=${nidx};
			frm.userid.value = "${user.userid}";
			frm.teamNum.value = "${user.teamNum}";
			frm.subject.value = subject;
			frm.content.value = content;
			frm.action="<%=request.getContextPath()%>/noticeEditWriteEnd.mr";
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
			
			var left = $("#tb").position().left-50;
			var bottom = $("#tb").position().bottom+10;
			$("#end").css({"right":left+"px", "bottom":bottom+"px"}); 
		});
	</script>
</body>
</html>