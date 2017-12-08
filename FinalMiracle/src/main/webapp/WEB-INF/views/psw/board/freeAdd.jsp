<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    


<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/jqueryuicss/jquery-ui.css" />
<link href="<%=request.getContextPath() %>/resources/summernote/summernote.css" rel="stylesheet">

<script type="text/javascript" src="<%= request.getContextPath() %>/resources/jqueryuijs/jquery-ui.js"></script>
<script src="<%=request.getContextPath() %>/resources/summernote/summernote.js"></script>
<script src="<%=request.getContextPath() %>/resources/summernote/lang/summernote-ko-KR.js"></script>

<style type="text/css">
	table, th, td, input, textarea {border: solid dimgray 1px;}
	
	#table {
	border-collapse: collapse;
	width: 80%;}
	#table th, #table td{padding: 10px; font-size: 13pt;}
	#table th{width: 120px; background-color: #DDDDDD;}
	#table td{width: 480px;}
	.long {width: 470px;}
	.short {width: 120px;} 		

</style>

<script type="text/javascript">

	$(document).ready(function(){
		// ===================================== *** summernote text area 편집기 불러오기 *** ==============
		$('.summernote').summernote({
		      height: 300,          // 기본 높이값
		      minHeight: null,      // 최소 높이값(null은 제한 없음)
		      maxHeight: null,      // 최대 높이값(null은 제한 없음)
		      focus: true,          // 페이지가 열릴때 포커스를 지정함
		      lang: 'ko-KR'         // 한국어 지정(기본값은 en-US)
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

<div style="color: navy; width: 100%; border: 1px solid red;" align="center" >
	<h1>자유게시판 글쓰기</h1>
	
	<div style="border: 1px solid blue; width: 90%;" >
		<form name="writeFrm">
			<table id="table">
			 
				<tr>
					<th>아이디</th>
					<td>
					    <input type="text" name="userid" value="${sessionScope.loginUser.userid}" class="short" readonly />
						<input type="hidden" name="name" value="${sessionScope.loginUser.name}" readonly />
					</td>
				</tr>
				 
				<tr>
					<th>글제목</th>
					<td>
						<input type="text" name="subject" class="long" />
					</td>
				</tr>
				
				<tr>
	            	<th>글내용</th>
	            	<td>
	            		<textarea name="content" id="content" class="summernote"></textarea>
	            	</td>
	         	</tr>
			</table>
			<br/>
			
			<button type="button" onClick="goWrite();">쓰기</button>
			<button type="button" onClick="javascript:history.back();">취소</button>
		</form>
	</div>

</div>	







