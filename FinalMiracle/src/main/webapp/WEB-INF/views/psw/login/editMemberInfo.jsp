<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내정보 수정</title>
</head>
<body>

<div>	
	<form class="form-horizontal">
		<fieldset>
		
		<!-- Form Name -->
		<legend>회원정보 수정</legend>
		
		<!-- Text input-->
		<div class="form-group">
		  <label class="col-md-4 control-label" for="name">성명</label>  
		  <div class="col-md-4">
		  <input id="name" name="name" type="text" placeholder="Name" class="form-control input-md" required="">
		  <span class="help-block">성명</span>  
		  </div>
		</div>
		
		<!-- Text input-->
		<div class="form-group">
		  <label class="col-md-4 control-label" for="아이디">아이디</label>  
		  <div class="col-md-4">
		  <input id="userid" name="아이디" type="text" placeholder="ID" class="form-control input-md" required="">
		  <span class="help-block">아이디</span>  
		  </div>
		</div>
		
		<!-- Password input-->
		<div class="form-group">
		  <label class="col-md-4 control-label" for="pwd">비밀번호</label>
		  <div class="col-md-4">
		    <input id="pwd" name="pwd" type="password" placeholder="password" class="form-control input-md" required="">
		    <span class="help-block">비밀번호 설정</span>
		  </div>
		</div>
		
		<!-- Text input-->
		<div class="form-group">
		  <label class="col-md-4 control-label" for="birth">생년월일</label>  
		  <div class="col-md-4">
		  <input id="birth" name="birth" type="text" placeholder="생년월일" class="form-control input-md" required="">
		  <span class="help-block">생년월일</span>  
		  </div>
		</div>
		
		<!-- Password input-->
		<div class="form-group">
		  <label class="col-md-4 control-label" for="pwdcheck">비밀번호 확인</label>
		  <div class="col-md-4">
		    <input id="pwdcheck" name="pwdcheck" type="password" placeholder="password" class="form-control input-md" required="">
		    <span class="help-block">비밀번호 확인</span>
		  </div>
		</div>
		
		<!-- Text input-->
		<div class="form-group">
		  <label class="col-md-4 control-label" for="email">이메일</label>  
		  <div class="col-md-4">
		  <input id="email" name="email" type="text" placeholder="이메일" class="form-control input-md" required="">
		  <span class="help-block">help</span>  
		  </div>
		</div>
		
		<!-- Text input-->
		<div class="form-group">
		  <label class="col-md-4 control-label" for="email">연락처</label>  
		  <div class="col-md-4">
		  <input id="email" name="email" type="text" placeholder="전화번호" class="form-control input-md" required="">
		  <span class="help-block">핸드폰번호</span>  
		  </div>
		</div>
		
		<!-- Text input-->
		<div class="form-group">
		  <label class="col-md-4 control-label" for="post">우편번호</label>  
		  <div class="col-md-4">
		  <input id="post" name="post" type="text" placeholder="우편번호" class="form-control input-md">
		  <span class="help-block">우편번호</span>  
		  </div>
		</div>
		
		<!-- Text input-->
		<div class="form-group">
		  <label class="col-md-4 control-label" for="addr1">기본주소</label>  
		  <div class="col-md-4">
		  <input id="addr1" name="addr1" type="text" placeholder="기본주소" class="form-control input-md" required="">
		  <span class="help-block">기본주소</span>  
		  </div>
		</div>
		
		<!-- Text input-->
		<div class="form-group">
		  <label class="col-md-4 control-label" for="addr2">상세주소</label>  
		  <div class="col-md-4">
		  <input id="addr2" name="addr2" type="text" placeholder="상세주소" class="form-control input-md" required="">
		  <span class="help-block">상세주소</span>  
		  </div>
		</div>
		
		<!-- Textarea -->
		<div class="form-group">
		  <label class="col-md-4 control-label" for="profile">프로필</label>
		  <div class="col-md-4">                     
		    <textarea class="form-control" id="profile" name="profile">자기소개</textarea>
		  </div>
		</div>
		
		</fieldset>
	</form>
</div>	

</body>
</html>