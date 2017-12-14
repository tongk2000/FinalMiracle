<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>이메일 보내기</title>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resources/BootStrapStudy/css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/jqueryuicss/jquery-ui.css" />
<link href="<%=request.getContextPath() %>/resources/summernote/summernote.css" rel="stylesheet">

<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/jquery-2.0.0.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/BootStrapStudy/js/bootstrap.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/jqueryuijs/jquery-ui.js"></script>
<script src="<%=request.getContextPath() %>/resources/summernote/summernote.js"></script>
<script src="<%=request.getContextPath() %>/resources/summernote/lang/summernote-ko-KR.js"></script>

<script type="text/javascript">
	$(document).ready(function(){
		
		$('.summernote').summernote({
	      height: 300,          // 기본 높이값
	      minHeight: null,      // 최소 높이값(null은 제한 없음)
	      maxHeight: null,      // 최대 높이값(null은 제한 없음)
	      focus: true,          // 페이지가 열릴때 포커스를 지정함
	      lang: 'ko-KR'         // 한국어 지정(기본값은 en-US)
	    });
		
	});
	
	function goEmail(){
		var content = document.getElementById("content").value;
		
		if(content.trim() == ""){
			alert("메일 내용을 입력해주세요.");
			return;
		} else {
			var frm = document.emailForm;
			
			frm.submit();
		}
	}
	
	function goClear(){
		var frm = document.emailForm;
		
		frm.subject.value = "";
		frm.content.value = "";
	}
</script>
</head>
<body>
	<form id="emailForm" name="emailForm" action="<%= request.getContextPath() %>/tmWriteEmailEnd.mr" method="post" enctype="multipart/form-data">
		<div>
			<div>
				<div style="width: 300px; float: left;">
					받는 이 : <input type="text" name="receiveEmail" id="receiveEmail" class="form-control" style="width: 300px;" value="${receiveEmail}" readonly="readonly" />
				</div>
				<div style="width: 300px; float: left;">
					보내는 이 :<input type="text" name="sendEmail" id="sendEmail" class="form-control" style="width: 300px;" value="${sendEmail}" readonly="readonly" />
				</div>
			</div>
			<br/>
			<div style="width: 800px;">
					<input type="text" name="subject" id="subject" class="form-control" style="width: 600px;" placeholder="메일제목을 입력해주세요" />
			</div>
			<br/>
			<div>
				<textarea name="content" id="content" class="summernote" placeholder="내용을 입력해주세요"></textarea>
			</div>
			<div align="center">
				<a href="javascript:goEmail();" class="btn btn-success"><span class="glyphicon glyphicon-envelope"></span> 메일 전송</a>
				<a href="javascript:goClear();" class="btn btn-warning"><span class="glyphicon glyphicon-repeat"></span> 초기화</a>
			</div>
		</div>
	</form>
</body>
</html>