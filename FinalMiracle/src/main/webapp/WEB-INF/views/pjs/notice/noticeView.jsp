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
	
</style>
</head>

<body>
<c:set var="user" value="${map}" /> <!-- teamNum , userid , teamNum , status -->
	<div> <!-- style="width:700px; float:right;" -->
		 <div style="border: 0px solid yellow; " align="center"> <!-- width:500px; -->
			<div style=" border:3px solid #337ab7; "> <!-- width:500px; -->
			 <span style="color:red"> 공지사항 글 </span><br/>
			 <span style="color:lightblue;">팀 프로젝트 중요사항 입니다.</span>
			</div><br/>
		
		 <div>
			<form name="editform">
			<table style="width:80%; margin:20px;">
				<thead>
					<tr>
						<th colspan="2" style="color:red; text-align:center; border-top:1px solid lightgray; "><span >공지글</span></th> <!-- style="size:20px;" -->
					</tr>
				</thead>
				<tbody>
					<tr style="text-align:right; border-bottom:1px solid lightgray;"> 
						<td colspan="2" style="text-align:right;"> 조회수 : ${info.readcount}  &nbsp;  작성일 : ${info.regday} </td>
					</tr>
					<tr style="border-top:1px solid lightgray; border-bottom:1px solid lightgray; ">
						<td style="width:30%;"><img src="<%= request.getContextPath() %>/resources/images/${user.img}" style="width:150px; heightL:100px;"> <br/>
						</td>
						<td> 아이디 : ${user.userid}<input type="hidden" name="fk_userid" value="${user.userid}"><br/><br/>
							 제목 : <input type="hidden" name="subject" value="${user.subject}">${user.subject}
						</td>
					</tr>
						
				</tbody>
			</table>
			<table style="width:80%;">
				<tr > <!-- style="min-height: 200px;"  -->
					<td id="edit1"><div >${user.content}</div></td> <!-- style="width:500px; height:500px;" -->
				</tr>
			</table>
			<table style="width:80%; border-top:1px solid lightgray; border-bottom:1px solid lightgray; margin:10px; "> 
				<tr >
					<td style="padding-top:1%; padding-bottom:1%; width:20%;">첨부파일</td>   <!-- USERID, IMG, SUBJECT, CONTENT, STATUS, IDX, FILENAME, ORGFILENAME, FILESIZE, FK_IDX -->
					<td style="padding-top:1%; padding-bottom:1%;">
					    <a href="<%= request.getContextPath() %>/download.mr?nidx=${user.n_idx}&fidx=${file.idx}">${file.orgFilename}</a> 
					</td>
				</tr>
			</table>
			</form>
		</div>
		
			<div style="display:inline;"> <!-- " -->
				<button type="button" onClick="goback();">목록보기</button>
			</div> 
			<c:if test="${sessionScope.teamInfo.teamwon_status == 2}">
				<div style="margin-left:80px; display:inline;" ><!--  -->
					<button type="button" onClick="goEdit();">수정글쓰기</button>
				</div>
			</c:if>
			
			<br/>
			<br/>
			<div id="displayList" ></div> <!-- style="background-color:white; align:center;" -->
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
			var data_form = {"nidx":"${nidx}"};
			$.ajax({
				url:"getnoticeReplyList.mr",
				type:"get",
				data:data_form,
				dataType:"html",
				success:function(data) {
					$("#displayList").html(data);
				},
				error:function() {
					//alert("getReply 실패");
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
		<%-- function goEdit() {
			var frm = document.edit;
			frm.nidx.value="${nidx}";
			frm.userid.value="${sessionScope.loginUser.userid}";
			frm.teamNum.value="${user.team_idx}";
			frm.action="<%=request.getContextPath()%>/noticeEditWrite.mr";
			frm.method="get";
			frm.submit();
		} --%>
		function goback() {
			location.href="<%=request.getContextPath()%>/${sessionScope.gobackURL}";
		}
		 function ajaxedit(content) {
			var form_data={content:content};
			
			$.ajax({
				url:"noticeViewEdit.mr",
				type:"post",
				data:form_data,
				dataType:"html",
				success:function(data) {
					//alert(data);
					$("#goedit").hide();
					var html =	"<button type='button' onClick='edit();'>완료</button>";
					$("#goedit").html(html).show();
					$("#edit1").html(data);
				},
				error:function () {
					//alert("에러");
				}
			})
		} 
	</script>
</body>
</html>