<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE>
<html>
<head>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/jqueryuicss/jquery-ui.css" />
<link href="<%=request.getContextPath() %>/resources/summernote/summernote.css" rel="stylesheet">
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/jqueryuijs/jquery-ui.js"></script>
<script src="<%=request.getContextPath() %>/resources/summernote/summernote.js"></script>
<script src="<%=request.getContextPath() %>/resources/summernote/lang/summernote-ko-KR.js"></script>
<meta charset="UTF-8">
<title>공지사항 글</title>
<style>
	.imgs {
		width:50px;
		heigth:50px;
	}
	div#displayList {
		width:80%;
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
		border:1px solid lightgray;
	}
	th {
		background-color:#337ab7;
	}
	
</style>
</head>
<body>
<c:set var="user" value="${map}" /> <!-- teamNum , userid , teamNum , status -->
	<div style="border: 0px solid green; width:100%;">
		<div style="border: 0px solid yellow;" align="center">
			<div style=" border:3px solid #337ab7; heigth:100px; border-left:none; border-right:none;  width:800px; " align="center"> 
			 <span style="color:red"> 공지사항 글 </span><br/>
			 <span style="color:lightblue;">팀 프로젝트 중요사항 입니다.</span>
			</div><br/>
			<form name="editform">
			<table>
				<thead>
					<tr>
						<th colspan="2" style="color:white;"><span style="size:20px;">공지글</span></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td width="12%">유저 아이디 : </td><td><img src="<%= request.getContextPath() %>/resources/images/${user.img}" class="imgs"> &nbsp;&nbsp; ${user.userid}<input type="hidden" name="userid" value="${user.userid}"></td>
					</tr>
					<tr>
						<td width="12%" >팀정보 : </td><td style="padding-left:12px;">${user.team_idx} 팀<input type="hidden" name="idx" value="${nidx}"/></td>
					</tr>
					<tr>
						<td width="12%">제목 :</td>
						<td><input type="text" value="${user.subject}" name="subject" /></td>
					</tr>
					<tr style="min-height: 200px;" >
						<td>내용 :</td>
						<td id="edit"><textarea name="content" id="content" class="summernote">${user.content}</textarea></td>
					</tr>
					<tr>
						<td>첨부파일</td>   <!-- USERID, IMG, SUBJECT, CONTENT, STATUS, IDX, FILENAME, ORGFILENAME, FILESIZE, FK_IDX -->
						<td>
						    <a href="<%= request.getContextPath() %>/download.mr?nidx=${user.n_idx}&fidx=${file.idx}">${file.orgFilename}</a> 
						</td>
					</tr>
				</tbody>
			</table>
			</form>
			<div style="display:inline; margin-left:40px;"  >
					<button type="button" onClick="goback();">목록보기</button>
			</div>
			<div style="margin-left:80px; display:inline;"  >
					<button type="button" onClick="goEdit();">완료</button>
				</div>
			<br/>
			<br/>
			<!-- <div id="displayList" style="background-color:white; align:center;"></div>
			<br/>
			<div style="align:center;">댓글 :&nbsp;&nbsp;<input type="text" id="contents" name="contents"/> <button type="button" id="goClick">쓰기</button></div> <br/><br/> -->
		</div>
	</div>
	<!-- <form name="edit">
		<input type="hidden" name="nidx">
		<input type="hidden" name="userid">
		<input type="hidden" name="teamNum">
		<input type="hidden" name="subject">
		<input type="hidden" name="content">
	</form> -->
	<!-- comment(ReplyVO), map(team_idx , userid) 받는다. -->
	
	
	
	
	
	<script>
		$(document).ready(function(){
			getReply();
			$("#goClick").click(function(){
				var contents = $("#contents").val();
				var nidx = "${nidx}";
				var userid = "${sessionScope.loginUser.userid}";
				goClick(nidx,contents, userid);
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
			var data_form = {"nidx":"${nidx}"}
			$.ajax({
				url:"getnoticeReplyList.mr",
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
		function goClick(idx, contents, userid) {
			$.ajax({
				url:"setnoticeReplyList.mr",
				type:"post",
				data:{"idx":idx,"contents":contents,"userid":userid}
			});
			getReply();				
		}
		function goEdit() {
			var frm = document.editform;
			/*frm.nidx.value="${nidx}";
			frm.userid.value="${user.userid}";
			frm.teamNum.value="${user.team_idx}";
			frm.subject.value="";
			frm.content.value=""; */
			frm.action="<%=request.getContextPath()%>/noticeViewEditEnd.mr";
			frm.method="post";
			frm.submit();
		}
		function goback() {
			location.href="<%=request.getContextPath()%>/${sessionScope.gobackURL}";
		}
		/* function ajaxedit(content) {
			var form_data={content:content};
			
			$.ajax({
				url:"noticeViewEdit.mr",
				type:"post",
				data:form_data,
				dataType:"html",
				success:function(data) {
					alert(data);
					$("#goedit").hide();
					var html =	"<button type='button' onClick='edit();'>완료</button>";
					$("#goedit").html(html).show();
					$("#edit").html(data);
				},
				error:function () {
					alert("에러");
				}
			})
		} */
	</script>
</body>
</html>