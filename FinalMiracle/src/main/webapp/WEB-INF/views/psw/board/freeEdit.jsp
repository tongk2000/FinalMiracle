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
	table, th, td, input, textarea {border: solid gray 1px;}
	
	#table, #table2 {border-collapse: collapse;
	 		         width: 600px;
	 		        }
	#table th, #table td{padding: 5px;}
	#table th{width: 120px; background-color: #DDDDDD;}
	#table td{width: 480px;}
	.long {width: 470px;}
	.short {width: 120px;} 	
	
	a{text-decoration: none;}	

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

<div style="padding-left: 10%; border: solid 0px red;">
	<h1>글수정</h1>
	
	<form name="editFrm">     
		<table id="table">
			<tr>
				<th>글번호</th>
				<td>${freevo.idx}
					<input type="hidden" name="idx" value="${freevo.idx}" />
				</td>
			</tr>
			<tr>
				<th>아이디</th>
				<td>${freevo.userid}</td>
			</tr>
			<tr>
				<th>성명</th>
				<td>${freevo.name}</td>
			</tr>
			<tr>
	           	<th>제목</th>
	           	<td><input type="text" name="subject" value="${freevo.subject}" style="width: 300px;" /></td>
	        	</tr>
			<tr>
				<th>내용</th>
				<td><textarea name="content" id="content" class="summernote">${freevo.content}</textarea></td>
			</tr>
		</table>
		
		<br/>
		<button type="button" onClick="goUpdate();">완료</button>
		<button type="button" onClick="javascript:history.back();">취소</button>
	
	</form>	
		
</div>

</body>
</html>