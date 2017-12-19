<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
	.modal.modal-center {
	  text-align: center;
	}
	
	@media screen and (min-width: 768px) { 
	  .modal.modal-center:before {
	    display: inline-block;
	    vertical-align: middle;
	    content: " ";
	    height: 100%;
	  }
	}
	
	.modal-dialog.modal-center {
	  display: inline-block;
	  text-align: left;
	  vertical-align: middle; 
	}

	a {
		text-decoration: none;
	}
	
	.mydiv {
		display: inline-block;
		position: relative;
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
		width: 90%;
		height: 15%;
		margin-bottom: 5%;
		position: relative;
	}
	
	#div_mobile {
		width: 90%;
		height: 15%;
		margin-bottom: 5%;
		position: relative;
	}
	
	#div_finalResult {
		width: 90%;
		height: 15%;
		margin-bottom: 5%;
		position: relative;
	}
	
	#div_btnFind {
		width: 90%;
		height: 15%;
		margin-bottom: 5%;
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
	    
		$("#btnIdFind").click(function(){
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
		
		// ============================================== *** 페이지 전체에서 esc 키를 누르면 모달창을 닫기 *** =======
		$(document).on("keydown", function(){
			var modalFlag = $('.modal').is(':visible');
			if(event.keyCode == 27 && modalFlag) { 
				$('.modal').modal('hide');
				var userid = $("#useridFind").text();
				$("#userid").val(userid);
			}
		}); // end of $("#body").keyup(function() --------------------------------------------------------
		
		// ======================== *** 모달창에서 x 나 Close 를 누르면 모달창 닫기 *** ==================================
		$(document).on("click", ".modalClose", function(){
			$('.modal').modal('hide');
			var userid = $("#useridFind").text();
			$("#userid").val(userid);
		}); // end of $(".modalClose").click(function() --------------------------------------------------
	 
    }); // end of $(document).ready()------------------------------------------------------------------------------------------------------------------- 

    
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
    
	function showPwdCheck() {
		$.ajax({
			url: "member_pwdFind.mr",
			type: "GET",
			dataType: "HTML", 
			success: function(data) {	
				$("#pwdFind").html(data);
				$("#passwdFind").modal();
			}, // end of success: function()----------
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		}); // end of $.ajax()------------------------
	}
</script>


</head>


<body background="<%= request.getContextPath() %>/resources/images/loginbg.png">

	<div class="content" style="width: 100%; border: 0px dotted pink; vertical-align: middle; margin-top: 10%;" align="center">
	<div class="content" style="width: 100%; vertical-align: middle; margin-top: 15%;" align="center">
		<div style="width: 600px; height: 400px; border-radius: 10px; background-color: #4F84C4; margin: 100px;">
			<div style="padding-top: 5px; padding-bottom: 5px;">
				<h2 style="text-align: center;"><span style="color: #FAE03C; font-family: verdana;">Miracle World</span></h2>
				<p class="bg-primary">&nbsp;</p>
			</div>
			
			<div>
				<form name="loginFrm">
					<div class="mydiv" style="border: 0px solid yellow;">
						<span class="mydisplay myfont" style="color: #DFCFBE; margin-top: 10px;">아이디</span>
						<span class="mydisplay myfont" style="margin-top: 31px; color: #DFCFBE;">암&nbsp;&nbsp;&nbsp;호</span>
					</div>
					<div class="mydiv" style="margin-left: 10px; border: 0px solid yellow;">
						<input class="mydisplay form-control" type="text" name="userid"	id="userid" placeholder="User-ID" size="15" />
						<input class="mydisplay form-control" style="margin-top: 15px;" type="password" name="pwd" id="pwd" placeholder="PassWord" size="15" />
					</div>
					<br/>
					<div class="mydiv" style="margin-top: 10px; margin-left: 5px;">
						<a title="아이디찾기" data-toggle="modal" class="modalOpen" data-target="#userIdfind" data-dismiss="modal">
							<span style="color: #DFCFBE; cursor: pointer;">ID 찾기</span>
						</a> &nbsp;	
						<a title="비밀번호찾기" data-toggle="modal" class="modalOpen" data-target="#passwdFind" data-dismiss="modal">
							<span style="color: #DFCFBE; cursor: pointer;">PW 찾기</span>
						</a>
						&nbsp;&nbsp;&nbsp;
						<button class="btn btn-sm btn-success" style="font-size: 11pt;" type="button" id="btnLOGIN">로그인</button>
					</div>
					<br/>
					<div class="mydiv" style="margin-top: 20px;">
						<span style="color: #DFCFBE;">아직 회원가입을 안하셨나요?</span> &nbsp; 
						<a href="<%= request.getContextPath() %>/member_register.mr" class="btn btn-sm btn-primary">
							<span class="glyphicon glyphicon-user"></span> 회원가입
						</a>
					</div>
					<br/>
					<div class="mydiv" style="margin-top: 30px; color: #DFCFBE;">Welcome to ⓒ Miracle World ~ !!</div>
				</form>
			</div>
		</div>
	</div>

</body>

		<%-- 아이디 찾기 Modal --%>
		<div class="modal fade modal-center" id="userIdfind" role="dialog">
			<div class="modal-dialog modal-center modal-sm">
				<%-- Modal content --%>
				<div class="modal-content" align="center">
					<div class="modal-header">
						<button type="button" class="close modalClose" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">아이디 찾기</h4>
					</div>
					<div class="modal-body modal-sm" style="width: 100%; height: 100%;">
						<div id="idFind">
							<div>
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
										<button type="button" class="btn btn-success" id="btnIdFind">찾기</button>
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
		<div class="modal fade modal-center" id="passwdFind" role="dialog">
			<div class="modal-dialog modal-center modal-sm">
				<%-- Modal content --%>
				<div class="modal-content" align="center">
					<div class="modal-header">
						<button type="button" class="close myclose" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">비밀번호 찾기</h4>
					</div>
					<div class="modal-body" style="width: 100%; height: 100%;">
						<div id="pwdFind">
							<iframe id="pwdFrame" style="border: none; width: 100%; height: 250px;" src="<%= request.getContextPath() %>/member_pwdFind.mr"></iframe>  
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default myclose" data-dismiss="modal">Close</button>
					</div>
				</div>

			</div>
		</div>