<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>프로필 사진 변경하기</title>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resources/BootStrapStudy/css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/jqueryuicss/jquery-ui.css" />
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css" />

<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/jquery-2.0.0.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/BootStrapStudy/js/bootstrap.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/jqueryuijs/jquery-ui.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/jquery.form.min.js"></script> <!-- 파일까지 업로드 가능한 jquery form 플러그인 -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>

<script type="text/javascript">

	function goAlterImgEnd() {
		var frm = document.alterImgFrm;
		frm.method = "post";
		frm.action = "<%= request.getContextPath() %>/member_alterImgEnd.mr";
		frm.submit();
	}

</script>

</head>


<body>

<div style="width: 100%; height: 100%; padding: 20px; background-color: #F0F0F0" align="center">

	<form name="alterImgFrm" enctype="multipart/form-data">
		<h4 style="text-align: center; font-weight: bold;">프로필 이미지 변경하기</h4>
		<div>
			<input style="padding-left: 30px;" type="file" name="img" id="img" accept="images/jpg, images/jpeg, images/png, images/gif" /><br/>
		
			<a class="btn btn-primary btn-success" style="text-align: center;" href="javascript:goAlterImgEnd();">확인</a>
		</div>
	</form>
	
</div>

</body>
</html>








