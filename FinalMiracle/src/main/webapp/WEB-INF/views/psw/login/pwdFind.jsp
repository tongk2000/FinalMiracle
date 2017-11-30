<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Miracle_PwdFind</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resources/BootStrapStudy/css/bootstrap.css">
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/jquery-2.0.0.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/BootStrapStudy/js/bootstrap.js"></script>

<style type="text/css">
	
	#div_userid {
		width: 70%;
		height: 15%;
		margin-bottom: 5%;
		margin-left: 10%;
		position: relative;
	}
	
	#div_email {
		width: 70%;
		height: 15%;
		margin-bottom: 5%;
		margin-left: 10%;
		position: relative;
	}
	
	#div_findResult {
		width: 70%;
		height: 15%;
		margin-bottom: 5%;
		margin-left: 10%;
		position: relative;
	}
	
	#div_btnFind {
		width: 70%;
		height: 15%;
		margin-bottom: 5%;
		margin-left: 10%;
		position: relative;
	}
	
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		var method = "${method}";
		var userid = "${userid}";
		var email = "${email}";
		var n = "${n}";
		
		if (method == "POST" && userid != "" && email != "") {
			$("#userid").val(userid);
			$("#email").val(email);
		}
		
		if (method == "POST" && n==1) {
			$("#div_btnFind").hide();	
			
		} else if (method == "POST" && (n== -1 || n==0) ) {
			$("#div_btnFind").show();
		}
		
		
		$("#btnFind").click(function(){
			var frm = document.pwdFindFrm;
			frm.method = "post";
			frm.action = "<%= request.getContextPath() %>/member_pwdFind.mr";
			frm.submit();
		});  // end of $("#btnFind").click() -------------------------
		
		
		$("#btnConfirmCode").click(function(){
			
			if ( "${certificationCode}" == $("#input_confirmCode").val() ) {
				alert("인증성공 되었습니다.");
				
				var frm = document.pwdFindFrm;
				frm.method = "get"; // 단순하게 폼만 띄워주는 것이므로
				frm.action = "<%= request.getContextPath() %>/member_pwdConfirm.mr";
				frm.submit();
				
			} else {
				alert("인증코드값을 다시 입력하세요.");
				$("#input_confirmCode").val("");
			}
		});  // end of $("#btnConfirmCode").click() --------------------
				
	});  // end of $(document).ready() ----------------------

</script>

</head>


<body>
		
<div class="content">

	<form name="pwdFindFrm">
	   <div id="div_userid" align="center">
	   	  <span style="color: blue; font-size: 12pt;" >아이디</span><br/>
	   	  <input type="text" id="userid" name="userid" size="15" placeholder="ID" required />
	   </div>
	   
	   <div id="div_email" align="center">
	   	  <span style="color: blue; font-size: 12pt;" >이메일</span><br/>
	   	  <input type="text" id="email" name="email" size="15" placeholder="abc@naver.com" required />
	   </div>
	   
	   <div id="div_findResult" align="center">
	   	   <c:if test="${n == 1}">
	   	   	  <div>
	   	   	  	인증코드가 ${email}로 발송되었습니다.<br/>
	   	   	  	인증코드를 입력해주세요<br/>
	   	   	  	<input type="text" id="input_confirmCode" name="input_confirmCode" required />
	   	   	  	<br/><br/>
	   	   	  	<button type="button" class="btn btn-info" id="btnConfirmCode">인증하기</button>
	   	   	  </div>
	   	   </c:if>
	   	   
	   	   <c:if test="${n == 0}">
	   	   		<span style="color: red;">사용자 정보가 없습니다.</span>
	   	   </c:if>
	   	   
	   	   <c:if test="${n == -1}">
	   	   		<span style="color: red;">${sendFailmsg}</span>
	   	   </c:if> 
	   </div>
	   
	   <div id="div_btnFind" align="center">
	   	  <button type="button" class="btn btn-success" id="btnFind">찾기</button>	
	   </div>
	   
	</form>

</div>


</body>
    
    
    
    
    
    
    
    