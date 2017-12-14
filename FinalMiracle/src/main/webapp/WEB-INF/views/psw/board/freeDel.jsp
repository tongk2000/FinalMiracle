<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유게시판 게시글 삭제</title>



<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/jqueryuicss/jquery-ui.css" />
<link href="<%=request.getContextPath() %>/resources/summernote/summernote.css" rel="stylesheet">

<script type="text/javascript" src="<%= request.getContextPath() %>/resources/jqueryuijs/jquery-ui.js"></script>
<script src="<%=request.getContextPath() %>/resources/summernote/summernote.js"></script>
<script src="<%=request.getContextPath() %>/resources/summernote/lang/summernote-ko-KR.js"></script>

<style type="text/css">
	table, th, td, textarea { 
		border: solid lightgray 1px;
		border-left: none;
		border-right: none;
	}
	
	#table, #table2 {
		border-collapse: collapse;
		width: 70%;
	}
	#table th, #table td{
		padding: 10px;}
	#table th{
		width: 10%; background-color: #DFCFBE;
	}
	#table td{
		width: 50%;
	}
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
		      lang: 'ko-KR'         // 한국어 지정(기본값은 en-US)
	    });
	}); // end of $(document).ready() -------------------------------------------------------

	function goDelete() {
		var delFrm = document.freeDelFrm;
		delFrm.action = "/board/frreeDelEnd.mr";
		delFrm.method = "post";
		delFrm.submit();
	}
</script>


</head>
<body>

<div style="padding-left: 10%; border: solid 0px red;">
	<div style="padding-top: 10px; ">
		<span style="font-size: 15pt; font-weight: bold;">자유게시판 </span>
		<span style="font-size: 13pt; font-family: verdana;">게시글 삭제</span>
	</div>
	<div>
		<form name="freeDelFrm">     
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
		           	<td><input type="text" name="subject" value="${freevo.subject}" style="width: 90%;;" /></td>
		        	</tr>
				<tr>
					<th>내용</th>
					<td><textarea name="content" id="content" class="summernote">${freevo.content}</textarea></td>
				</tr>
			</table>
			
			<div>
				<br/>
				<button type="button" onClick="goDelete();">삭제하기</button>
				<button type="button" onClick="javascript:history.back();">돌아가기</button>
			</div>
		
		</form>	
	</div>
		
</div>

</body>
</html>