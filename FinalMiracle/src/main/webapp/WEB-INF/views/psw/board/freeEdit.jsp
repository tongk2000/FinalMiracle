<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유게시판 게시글 수정</title>



<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/jqueryuicss/jquery-ui.css" />
<link href="<%=request.getContextPath() %>/resources/summernote/summernote.css" rel="stylesheet">

<script type="text/javascript" src="<%= request.getContextPath() %>/resources/jqueryuijs/jquery-ui.js"></script>
<script src="<%=request.getContextPath() %>/resources/summernote/summernote.js"></script>
<script src="<%=request.getContextPath() %>/resources/summernote/lang/summernote-ko-KR.js"></script>

<style type="text/css">

	.freeEditButtonHoverStyle {
		font-weight: bold;
		font-style: italic;
	}

</style>

<script type="text/javascript">
	$(document).ready(function(){
		// ===================================== *** summernote text area 편집기 불러오기 *** ==============
		$('.summernote').summernote({
		      height: 300,          // 기본 높이값
		      minHeight: null,      // 최소 높이값(null은 제한 없음)
		      maxHeight: null,      // 최대 높이값(null은 제한 없음)
		      //focus: true,        // 페이지가 열릴때 포커스를 지정함
		      lang: 'ko-KR'         // 한국어 지정(기본값은 en-US)
	    });
		// ================================== *** 수정, 돌아가기 버튼 타겟시 hover 효과 주기 *** ============================
		$(".freeEditButton").hover(function(){ 
			$(this).addClass("freeEditButtonHoverStyle");
		},function(){
			$(this).removeClass("freeEditButtonHoverStyle");
		});
	}); // end of $(document).ready() -------------------------------------------------------

	function goUpdate() {
		// 유효성 검사 생략
		var editFrm = document.editFrm;
		editFrm.action = "<%= request.getContextPath() %>/freeEditEnd.mr";
		editFrm.method = "post";
		editFrm.submit();
	}
</script>


</head>
<body>

<div style="width: 100%; height: 100%; border: solid 0px red; overflow-y: auto; padding-bottom: 100px;" align="center">
	
	<div style="width: 800px; padding-top: 30px;" align="left">
		<table id="table" style="width: 600px; border: 0px solid dimgray; border-left: none; border-right: none;">
		
			<!-- ============================= *** 자유게시판 내 게시글 수정 *** =================================== -->
			<tr style="background-color: lightblue; padding: 5px; border: 1px solid lightgray; border-left: none; border-right: none;">
				<td colspan="2" style="padding: 5px; font-weight: bold; font-size: 10pt;">

					<span style="vertical-align: baseline; color: #034f84; font-size: smaller;">[${fk_team_idx}팀]</span> 자유게시판 글 수정하기

				</td>
			</tr>
			<tr class="title" style="border: 1px solid lightgray; border-left: none; border-right: none;">
				<td colspan="2" style="padding: 10px; font-size: 10pt; border-bottom: none;">
					미풍양속을 해치지 않는 범위 내에서 자유롭게 작성해주세요.<br/>
					단, 팀원간 마찰은 <a href="<%= request.getContextPath() %>/mindList.mr">마음의 소리 게시판</a>을,
					        팀내 공지사항은 <a href="<%= request.getContextPath() %>/noticeList.mr">공지사항</a> 게시판을,
					<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1:1 대화를 원하시는 회원님은 <a href="<%= request.getContextPath() %>/mindList.mr">쪽지</a> 또는 
					<a href="<%= request.getContextPath() %>/chatting.mr">채팅</a> 기능을 이용해주시기 바랍니다.
				</td>
			</tr>
			<!-- ============================= *** 공 백 *** ================================ -->
			<tr style="border: 1px solid lightgray; border-top: none; border-left: none; border-right: none; border-bottom: none;">
				<td colspan="2" style="border-bottom: none;"> 
					<br/>									
				</td>
			</tr>
		</table >
	</div>
	
	<div style="width: 800px;" align="left">
		<form name="editFrm">     
			<table id="table">
				<tr style="width: 800px; border: 1px solid lightgray; border-left: none; border-right: none; padding: 10px;">
					<th style="width: 100px; background-color: #E0E0E0; text-align: center; padding: 10px;">글번호</th>
					
					<td style="padding-left: 20px; font-family: verdana;">
						${freevo.idx}
						<input type="hidden" name="idx" value="${freevo.idx}" />
					</td>
				</tr>
				<tr style="width: 800px; border: 1px solid lightgray; border-left: none; border-right: none; padding: 10px;">
					<th style="width: 100px; background-color: #E0E0E0; text-align: center; padding: 10px;">아이디</th>
					
					<td style="padding-left: 20px; font-family: verdana;">
						${freevo.userid}
					</td>
				</tr>
				<tr style="width: 800px; border: 1px solid lightgray; border-left: none; border-right: none; padding: 10px;">
					<th style="width: 100px; background-color: #E0E0E0; text-align: center; padding: 10px;">성명</th>
					
					<td style="padding-left: 20px; font-family: verdana;">
						${freevo.name}
					</td>
				</tr>
				<tr style="width: 800px; border: 1px solid lightgray; border-left: none; border-right: none; padding: 10px;">
		           	<th style="width: 100px; background-color: #E0E0E0; text-align: center; padding: 10px;">제목</th>
		           	
		           	<td style="padding-left: 20px; font-family: verdana;">
		           		<input type="text" name="subject" value="${freevo.subject}" style="width: 90%;;" />
		           	</td>
		        	</tr>
				<tr style="width: 800px; border: 1px solid lightgray; border-left: none; border-right: none; padding: 10px;">
					<th style="width: 100px; background-color: #E0E0E0; text-align: center; padding: 10px;">내용</th>
					
					<td style="padding-left: 20px; padding: 10px; font-family: verdana;">
						<textarea name="content" id="content" class="summernote">${freevo.content}</textarea>
					</td>
				</tr>
			</table>
			
			<div align="right">
				<br/>
				<span class="freeEditButton" style="font-size: 11pt; font-family: verdana; font-weight: bold; cursor: pointer;" onClick="goUpdate();">수정하기</span>&nbsp;&nbsp;
				<span class="freeEditButton" style="font-size: 11pt; font-family: verdana; font-weight: bold; cursor: pointer;" onClick="javascript:history.back();">취소</span>
			</div>
		
		</form>	
	</div>
		
</div>

</body>
</html>