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

	th {
		font-family: verdana;
		font-size: 11pt;
		padding: 10px;
		font-weight: bold;
	}
	
	tr {
		border: 1px solid lightgray;
	}
	
	td {
		font-family: verdana;
		font-size: 10pt;
		padding: 10px;
	}
	
	
	
</style>
</head>
<body>

<c:set var="user" value="${map}" />  <!-- teamNum , userid , teamNum , memberNum, status -->
	<div style="width:100%; height:100%; padding-top: 30px; padding-bottom: 100px; overflow-y: auto;" align="center">
		<div style="border: 0px solid yellow;">
			<form name="end" enctype="multipart/form-data"> 
				<table style="border: 1px solid lightgray; width: 80%;">
					<thead>
						<tr>
							<th colspan="2" style="font-weight: bold; font-size: 14pt;">마음의 소리</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td width="12%" style="border:1px solid lightgray; background-color:#E0E0E0; font-size: 12pt; font-weight: bold;">유저 아이디 </td><td><img src="<%= request.getContextPath() %>/resources/images/${user.img}" class="img"> &nbsp;&nbsp; ${user.userid}
							<input type="hidden" name="userid" value="${user.userid}"><input type="hidden" name="nidx"></td>
						</tr>
						<tr>
							<td width="12%" style="border:1px solid lightgray; background-color:#E0E0E0; font-size: 12pt; font-weight: bold;">팀정보 </td><td>${user.teamNum}<input type="hidden" name="teamNum" value="${user.teamNum}"></td>
						</tr>
						<tr>
							<td width="12%" style="border:1px solid lightgray; background-color:#E0E0E0; font-size: 12pt; font-weight: bold;">제목 </td>
							<td><input id="subject" type="text" name="subject"/></td>
						</tr>
						<tr style="min-height: 200px;">
							<td style="border:1px solid lightgray; background-color:#E0E0E0; font-size: 12pt; font-weight: bold;">내용 </td>
							<td height="200px"><textarea name="content" id="content" class="summernote"></textarea><input type="hidden" name="chkid"></td>
						</tr>
						<tr>
						   <td style="border:1px solid lightgray; background-color:#E0E0E0; font-size: 12pt; font-weight: bold;">파일첨부</td>
						   <td><input type="file" name="attach" id="attach"/></td>
						</tr>
					</tbody>
				</table>
			</form>
			
			<div style="display:block; float:right; margin-right: 10%; margin-top: 10px;">
				<button type="button" onClick="writeEnd();"  class="btn btn-default">완료</button>
				<button type="button" onClick="goback();"  class="btn btn-default">취소</button>
			</div>
		</div>
	</div>
	<script>
		function writeEnd() {
			var frm = document.end; // nidx, subject, content ,userid, teanNum
			/* var subject = $("#subject").val();
			var content = $("#content").val(); */
			
			var nidx = "${nidx}";  // 수정글의 idx
			frm.nidx.value = "${nidx}"; 
			if(nidx == null || nidx=="") { // 일반글쓰기 //if(nidx == null || nidx=="") {
				frm.userid.value = "${user.userid}";
			}
			if(nidx!=null && nidx!=""){ // 답변글쓰기 // if(nidx!=null && nidx!=""){
				frm.userid.value = "${sessionScope.loginUser.userid}";
				frm.chkid.value = "${chkid}";
			}
			//frm.idx.value=idx;
			//alert(idx);
			frm.action="<%=request.getContextPath()%>/mindWriteEnd.mr";
			frm.method="post";
			frm.submit();
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
		});
	</script>
</body>
</html>