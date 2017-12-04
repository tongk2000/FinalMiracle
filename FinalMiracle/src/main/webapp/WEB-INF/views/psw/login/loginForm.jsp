<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Miracle_로그인</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resources/BootStrapStudy/css/bootstrap.css">
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/jquery-2.0.0.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/BootStrapStudy/js/bootstrap.js"></script>

<style type="text/css">
	a {
		text-decoration: none;
	}
	
	.mydiv {
		display: inline-block;
		position: relative;
		top: 30px;
		line-height: 150%;
	}
	
	.mydisplay {
		display: block;
	}
	
	.myfont {
		font-size: 14pt;
		color: white;
		font-weight: bold;
	}
	
	#div_name {
		width: 70%;
		height: 15%;
		margin-bottom: 5%;
		margin-left: 10%;
		position: relative;
	}
	
	#div_mobile {
		width: 70%;
		height: 15%;
		margin-bottom: 5%;
		margin-left: 10%;
		position: relative;
	}
	
	#div_finalResult {
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
 
     $(document).ready(function() { 
    	 $("#btnLOGIN").click(function() {
    		 func_Login(event);
    	 }); // end of $("#btnLOGIN").click();-----------------------
    	 
    	 $("#pwd").keydown(function(event) {  
  			if(event.keyCode == 13) { 
  				func_Login(event);
  			}
    	 }); // end of $("#pwd").keydown();-----------------------	
    	 
    	 var method = "${method}";
    		
 	    if (method == "GET") {
 	       $("#div_finalResult").hide();
 	       $("#name").val("");
 		   $("#mobile").val("");
 	    }
 	    
 		$("#btnFind").click(function(){
 			var frm = $("form[name=idFindFrm]").serialize();
 			$.ajax({
 				url:"member_idFind.mr",
 				type:"post",
 				data:frm,
 				dataType:"JSON",
 				success:function(data){
 					$("#useridFind").text(data.userid);
 				}, error:function(){
 					alert("시스템오류. 관리자에게 문의하세요.");
 				}
 			});
 		});
 		
 		if (method == "POST") {
 		    $("#name").val("${name}");
 		    $("#mobile").val("${mobile}");
 		    $("#div_finalResult").show();
 		}
 		
 		$(".modalOpen").click(function(){
 			$("#mobile").val("");
 			$("#name").val("");
 			$("#useridFind").text("");
 		});
 		
 		// 페이지 전체에서 esc 키를 누르면 모달창을 닫기
		$(document).on("keydown", function(){
			var modalFlag = $('.modal').is(':visible');
			if(event.keyCode == 27 && modalFlag) { 
				$('.modal').modal('hide');
				var userid = $("#useridFind").text();
				$("#userid").val(userid);
			}
		}); // end of $("#body").keyup(function() ------------------------------------------------------------------------------------------------------
		
		// 모달창에서 x 나 취소를 누르면 모달창 닫기
		$(document).on("click", ".modalClose", function(){
			$('.modal').modal('hide');
			var userid = $("#useridFind").text();
			$("#userid").val(userid);
		}); // end of $(".modalClose").click(function() ------------------------------------------------------------------------------------------------------
	 
    }); // end of $(document).ready()---------------------------	 

    
    function func_Login(event) {
    	
    	if(${sessionScope.loginUser != null}) {
			 alert("이미 로그인 중입니다.");
			 $("#userid").val(""); 
			 $("#pwd").val("");
			 $("#userid").focus();
			 event.preventDefault();
			 return; 
		 }
		 
		 var userid = $("#userid").val(); 
		 var pwd = $("#pwd").val(); 
		
		 if(userid.trim()=="") {
		 	 alert("아이디를 입력하세요.");
			 $("#userid").val(""); 
			 $("#userid").focus();
			 event.preventDefault();
			 return;
		 }
		
		 if(pwd.trim()=="") {
			 alert("비밀번호를 입력하세요.");
			 $("#pwd").val("");
			 $("#pwd").focus();
			 event.preventDefault();
			 return;
		 }
		 document.loginFrm.action = "<%= request.getContextPath() %>/member_loginEnd.mr";
		 document.loginFrm.method = "post";
		 document.loginFrm.submit();
		 
    }  // end of function func_Login(event)-----------------------------
     
</script>


</head>


<body>
	<div class="content">
		<div style="width: 60%; margin-top: 10%; margin-left: 20%; height: 500px; border-radius: 10px; background-color: #4F84C4;">
			<br />
			<h2 style="text-align: center;">
				<span style="color: #FAE03C;">Miracle World</span>
			</h2>
			<p class="bg-primary">&nbsp;</p>

			<form name="loginFrm" style="margin-left: 20%;">
				<div class="mydiv" style="margin-left: 15%;" align="center">
					<span class="mydisplay myfont">아이디</span> <span
						class="mydisplay myfont" style="margin-top: 30px;">암&nbsp;&nbsp;&nbsp;호</span>
				</div>
				<div class="mydiv" style="margin-left: 5%;">
					<input class="mydisplay form-control" type="text" name="userid"	id="userid" size="20" /> 
					<input class="mydisplay form-control" style="margin-top: 15px;" type="password" name="pwd" id="pwd" size="20" />
				</div>
				<br /><br />
				<div class="mydiv" style="margin-left: 20%;">
					<a data-toggle="modal" class="modalOpen" data-target="#userIdfind" data-dismiss="modal">
						<span style="color: white;">ID 찾기</span>
					</a> / 
					<a data-toggle="modal" class="modalOpen" data-target="#passwdFind" data-dismiss="modal">
						<span style="color: white;">PW 찾기</span>
					</a>
					&nbsp;&nbsp;&nbsp;
					<button class="btn btn-success" style="width: 100px; font-size: 14pt;" type="button" id="btnLOGIN">로그인</button>
				</div>
				<br/><br/>
				<div class="mydiv" style="margin-left: 18%;">
					아직 회원가입을 안하셨나요? &nbsp; 
					<a href="<%= request.getContextPath() %>/member_register.mr">
						<span style="color: orange; font-weight: bold;">[회원가입]</span>
					</a>
				</div>
				<br/><br/>
				<div class="mydiv" style="margin-left: 20%;">Welcome to ⓒ Miracle World ~ !!</div>
			</form>
		</div>


		<%-- 아이디 찾기 Modal --%>
		<div class="modal fade" id="userIdfind" role="dialog">
			<div class="modal-dialog">
				<%-- Modal content --%>
				<div class="modal-content" align="center">
					<div class="modal-header">
						<button type="button" class="close modalClose" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">아이디 찾기</h4>
					</div>
					<div class="modal-body" style="width: 100%; height: 400px;">
						<div id="idFind">
							<div class="content">
								<form name="idFindFrm">
									<div id="div_name" align="center">
										<span style="color: blue; font-size: 12pt;">성명</span><br /> 
										<input type="text" id="name" name="name" size="15" placeholder="성명" required />
									</div>
									<div id="div_mobile" align="center">
										<span style="color: blue; font-size: 12pt;">휴대전화</span><br />
										<input type="text" id="mobile" name="mobile" size="15" placeholder="-없이 입력하세요" required />
									</div>
									<div id="div_finalResult" align="center">
										ID : <span style="color: red; font-size: 16pt; font-weight: bold;" id="useridFind"></span>
									</div>
									<div id="div_btnFind" align="center">
										<button type="button" class="btn btn-success" id="btnFind">찾기</button>
									</div>
								</form>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default modalClose" data-dismiss="modal">Close</button>
					</div>
				</div>
			</div>
		</div>


		<%-- 비밀번호 찾기 Modal --%>
		<div class="modal fade" id="passwdFind" role="dialog">
			<div class="modal-dialog">
				<%-- Modal content --%>
				<div class="modal-content" align="center">
					<div class="modal-header">
						<button type="button" class="close myclose" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">비밀번호 찾기</h4>
					</div>
					<div class="modal-body" style="width: 100%; height: 400px;">
						<div id="pwdFind">
							<iframe style="border: none; width: 100%; height: 350px;" src="<%= request.getContextPath() %>/member_pwdFind.mr"></iframe>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default myclose" data-dismiss="modal">Close</button>
					</div>
				</div>

			</div>
		</div>

	</div>

</body>