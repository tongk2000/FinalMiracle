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
	table, th, td, textarea {
		border: solid darkgray 1px;
		border-left: none;
		border-right: none;
	}
	
	#table {
		border-collapse: collapse;
		width: 70%;
	}
	#table th, #table td{
		padding: 10px;
		font-size: 11pt;
	}
	#table th{
		width: 10%; 
		background-color: #DFCFBE;
	}
	#table td{
		width: 50%;
	}
	.long {width: 470px;}
	.short {width: 120px;}
	
	.addButtonStyle {
		text-decoration: inherit;
		font-style: italic;
		font-size: 12pt;
		color: navy;
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

<div style="margin-left: 10%; width: 90%; border: 0px solid red;">
	<div>
		<span style="font-size: 14pt; font-weight: bold; font-family: verdana;">자유게시판</span>
		<span style="font-size: 12pt; font-weight: bold; font-family: arial;"> 글쓰기</span>
	</div>
	
	<div style="border: 0px solid blue; width: 80%;" >
		<form name="writeFrm">
			<table id="table">
			 
				<tr>
					<th>아이디</th>
					<td>
					    <input type="text" name="userid" value="${sessionScope.loginUser.userid}" class="short" readonly />
						<input type="hidden" name="name" value="${sessionScope.loginUser.name}" readonly />
						<input type="hidden" name="fk_teamwon_idx" value="${sessionScope.teamInfo.teamwon_idx}" readonly />
					</td>
				</tr>
				 
				<tr>
					<th>글제목</th>
					<td>
						<input type="text" name="subject" id="subject" class="long" />
					</td>
				</tr>
				
				<tr>
	            	<th>글내용</th>
	            	<td>
	            		<textarea name="content" id="content" class="summernote"></textarea>
	            	</td>
	         	</tr>
			</table>
			
			<!-- ================ *** 답변글쓰기가 추가된 경우 *** ================= -->
			<input type="hidden" name="fk_idx" value="${fk_idx}" />
			<input type="hidden" name="groupno" value="${groupno}" />
			<input type="hidden" name="depthno" value="${depthno}" />
			
			<div style="float: right; margin-right: 30%; margin-top: 10px;">
				<span class="addButton" style="font-size: 11pt; font-family: verdana; font-weight: bold; cursor: pointer;" onClick="goWrite();">글쓰기</span>&nbsp;&nbsp;
				<span class="addButton" style="font-size: 11pt; font-family: verdana; font-weight: bold; cursor: pointer;" onClick="javascript:history.back();">취소</span>
			</div>
		
		</form>
		
	</div>

</div>	



</body>



