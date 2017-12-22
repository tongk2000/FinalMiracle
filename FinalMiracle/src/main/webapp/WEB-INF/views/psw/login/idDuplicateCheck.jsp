<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Miracle_아이디중복검사</title>

<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resources/BootStrapStudy/css/bootstrap.css">
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/jquery-2.0.0.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/BootStrapStudy/js/bootstrap.js"></script>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css_psw/style.css">

<script type="text/javascript">

	function goCheck() {
		
		var userid = document.getElementById("userid");
		
		if(!userid.value || userid.value.trim()=="" ) {
		// 자바스크립트에서 null 은 false 로 인식한다.	
		    alert("아이디를 입력하세요!!");
		    userid.value = "";
		    userid.focus();
		}
		else {
			var frm = document.frmIdDuplicateCheck; 
			frm.method="post";
			frm.action="member_idDuplicateCheck.mr";
			frm.submit();	
		}
		
	}// end of goCheck()--------------
	
	
	function setUserID(userid) {
		
		var openerfrm = opener.document.registerFrm;
		// opener 는 팝업창을 열게한 부모창을 말한다.
		// 여기서 부모창은 memberRegisterForm.jsp 회원가입 페이지이다.
		openerfrm.userid.value = userid;
		openerfrm.pwd.focus();
		
		self.close();
		// 여기서 self 는 팝업창 자기자신을 말한다.
		// 지금의 self 는 idDuplicateCheck.jsp 페이지 이다.
	}

</script>

</head>
<body style="background-color: #deeaee;">


<c:if test="${method == 'GET'}">
<form name="frmIdDuplicateCheck">
	<div style="padding: 50px;" align="center">
		<table style="width: 95%; height: 90%;">
			<tr>
				<td style="text-align: center;">
						<span style="font-size: 12pt; font-weight: bold; color: #034f84; font-family: verdana;">아이디를 입력하세요<br style="line-height: 200%;"/></span>
						<input type="text" id="userid" name="userid" size="20" class="box" /><br style="line-height: 300%;"/>
						<a onClick="goCheck();" class="btn btn-sm btn-primary">중복 확인</a>
				</td>
			</tr>
		</table>
	</div>
</form>
</c:if>

<c:if test="${method == 'POST'}">

	<c:if test="${isUseuserid == true}">
		<br style="line-height: 200%"/>
		<br style="line-height: 200%"/>   
		<div align="center">
			<span style="font-family: verdana; font-size: 11pt; font-weight: bold;">아이디 [<span style="color:red; font-weight: bold; font-size: 14pt;">${userid}</span>] 사용 가능</span>
			<br/><br/><br/>
			<a onClick="setUserID('${userid}');" class="btn btn-sm btn-primary">닫기</a>
		</div>
	</c:if>
	
	<c:if test="${isUseuserid == false}">
			<br style="line-height: 200%"/>   
			<div align="center">
				<span style="color:red; font-weight: bold;">[${userid}]는 이미 사용중입니다.</span>
				<br/>
			
				<form name="frmIdDuplicateCheck" action="member_idDuplicateCheck.mr" method="post">
		          <table style="width: 95%; height: 90%;">
			      <tr>
				     <td style="text-align: center;">
						아이디를 입력하세요<br style="line-height: 200%;"/>
						<input type="text" id="userid" name="userid" size="20" class="box" /><br style="line-height: 300%;"/>
						<button type="button" class="box" onClick="goCheck();">확인</button>
					 </td>
			      </tr>
		          </table>
	            </form>
			</div>
	</c:if>

</c:if>

</body>
</html>





