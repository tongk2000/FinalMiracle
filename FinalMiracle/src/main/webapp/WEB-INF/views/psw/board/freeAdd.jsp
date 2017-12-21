<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<head>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/jqueryuicss/jquery-ui.css" />
<link href="<%=request.getContextPath() %>/resources/summernote/summernote.css" rel="stylesheet">

<script type="text/javascript" src="<%= request.getContextPath() %>/resources/jqueryuijs/jquery-ui.js"></script>
<script src="<%=request.getContextPath() %>/resources/summernote/summernote.js"></script>
<script src="<%=request.getContextPath() %>/resources/summernote/lang/summernote-ko-KR.js"></script>

<style type="text/css">
	.addButtonStyle {
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
		
		$(".addButton").bind("mouseover", function(event){
			var $target = $(event.target);
			$target.addClass("addButtonStyle");
		});
		$(".addButton").bind("mouseout", function(event){
			var $target = $(event.target);
			$target.removeClass("addButtonStyle");
		});
		
	}); // end of $(document).ready() -------------------------------------------------------

	function goWrite() {
		// 유효성 검사는 생략 하겠음.
		var writeFrm = document.writeFrm;
		writeFrm.action = "<%= request.getContextPath() %>/freeAddEnd.mr";
		writeFrm.method = "post";
		writeFrm.submit();
	}
</script>
</head>


<body>

<div style="width: 100%; height: 100%; border: 0px dotted pink; padding-bottom: 100px; overflow-y: auto;" align="center">
	<div style="width: 800px; border: 0px solid red;">
	
		<div style="width: 800px; padding-top: 30px;" align="left">
			<table id="table" style="width: 600px; border: 0px solid dimgray; border-left: none; border-right: none;">
			
				<!-- ============================= *** 자유게시판 원글쓰기 / 답변글 쓰기 *** =================================== -->
				<tr style="background-color: lightblue; padding: 5px; border: 1px solid lightgray; border-left: none; border-right: none;">
					<td colspan="2" style="padding: 5px; font-weight: bold; font-size: 10pt;">

						<span style="vertical-align: baseline; color: #034f84; font-size: smaller;">[${fk_team_idx}팀]</span> 
						<span style="font-family: verdana; font-size: 12pt; font-weight: bold;">자유게시판 글쓰기</span> <br/>
						<c:if test="${groupno ne null}">
							<span style="vertical-align: baseline; color: #034f84; font-size: smaller; padding-left: 30px;">${fk_idx}번 게시글</span>
							<span style="font-family: verdana; font-size: 9pt;">에 대한 답변글 작성하기</span>
						</c:if>
						<c:if test="${groupno eq null}">
							
						</c:if>
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
		
		<div style="border: 0px solid blue; width: 800px;" >
			<form name="writeFrm">
				<table id="table" style="border: 1px solid lightgray; width: 800px; border-left: none; border-right: none;">
					<tr style="border: 1px solid lightgray; border-left: none; border-right: none;">
					
						<th style="width: 100px; background-color: #E8E8E8; padding: 10px; text-align: center;">아이디</th>
						
						<td style="padding: 5px; padding-left: 10px;">
						    <input type="text" name="userid" value="${sessionScope.loginUser.userid}" class="short" readonly />
							<input type="hidden" name="name" value="${sessionScope.loginUser.name}" readonly />
							<input type="hidden" name="fk_teamwon_idx" value="${sessionScope.teamInfo.teamwon_idx}" readonly />
						</td>
					</tr>
					 
					<tr style="width: 100px; border: 1px solid lightgray; border-left: none; border-right: none;">
					
						<th style="background-color: #E8E8E8; padding: 10px; text-align: center;">글제목</th>
						
						<td style="padding: 5px; padding-left: 10px;">
							<input type="text" name="subject" id="subject" class="long" />
						</td>
					</tr>
					
					<tr style="width: 100px; border: 1px solid lightgray; border-left: none; border-right: none;">
					
		            	<th style="background-color: #E8E8E8; padding: 10px; text-align: center;">글내용</th>
		            	
		            	<td style="padding: 5px;">
		            		<textarea name="content" id="content" class="summernote"></textarea>
		            	</td>
		         	</tr>
				</table>
				
				<!-- ================ *** 답변글쓰기가 추가된 경우 *** ================= -->
				<input type="hidden" name="fk_idx" value="${fk_idx}" />
				<input type="hidden" name="groupno" value="${groupno}" />
				<input type="hidden" name="depthno" value="${depthno}" />
				
				<div style="margin-top: 10px; margin-right: 30px;" align="right">
					<span class="addButton" style="font-size: 11pt; font-family: verdana; font-weight: bold; cursor: pointer;" onClick="goWrite();">글쓰기</span>&nbsp;&nbsp;
					<span class="addButton" style="font-size: 11pt; font-family: verdana; font-weight: bold; cursor: pointer;" onClick="javascript:history.back();">취소</span>
				</div>
			
			</form>
			
		</div>
		
	</div>
</div>	



</body>



