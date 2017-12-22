<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>프로필 사진 변경하기</title>

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

	<form name="alterImgFrm" enctype="multipart/form-data">
		이미지 변경하기
		<input type="file" name="img" id="img" accept="images/jpg, images/jpeg, images/png, images/gif" />
		
		<a href="javascript:goAlterImgEnd();">확인</a>
	</form>
	
</body>
</html>