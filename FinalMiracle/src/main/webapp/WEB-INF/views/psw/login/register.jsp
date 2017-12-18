<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Miracle_회원가입</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/resources/BootStrapStudy/css/bootstrap.css">
<script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/js/jquery-2.0.0.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/BootStrapStudy/js/bootstrap.js"></script>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<style>
.content {
	border-radius: 15px;
	width: 350px;
	margin-top: 50px;
	margin-left: 10px;
}
/* 
table#tblMemberRegister {
	width: 500px;
	border-collapse: collapse;
	margin: 10px;
}

table#tblMemberRegister #th {
	height: 40px;
	width: 100px;
	text-align: center;
	background-color: silver;
	font-size: 13pt;
}
*/
table#tblMemberRegister td {
	text-align: center;
	height: 50px;
}

th#th {
	background-color: darkgray;
	font-size: 13pt;
}
 
.star {
	color: purple;
	font-weight: bold;
	font-size: 13pt;
}
</style>


<script type="text/javascript">
	$(document).ready(function() {
		$(".error").hide();

		$(".requiredInfo").each(function() {
			$(this).blur(function() {
				var data = $(this).val().trim();

				if (data.length == 0) {
					$(this).parent().find(".error").show();
					$(":input").attr("disabled",true).addClass("bgcol");
					$(this).attr("disabled",false).removeClass("bgcol");
					$("#btnRegister").attr("disabled",true);
					$(this).focus();
				} else {
					$(this).parent().find(".error").hide();
					$(":input").attr("disabled",false).removeClass("bgcol");
					$("#btnRegister").attr("disabled",false);
				}
			});
		});// end of $(".requiredInfo").each()------------

		$("#pwd").blur(function() {
			var pwd = $(this).val();
			var pattern = new RegExp(/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g);
			// 암호는 숫자/영문자/특수문자/ 포함 형태의  8~15자리 이내만 허락해주는 정규표현식 객체생성
			var bool = pattern.test(pwd);

			if (!bool) {
				$(this).next().show();
				$(":input").attr("disabled",true).addClass("bgcol");
				$(this).attr("disabled", false).removeClass("bgcol");
				$("#btnRegister").attr("disabled", true);
				$(this).val("");
				$(this).focus();
			} else {
				$(this).next().hide();
				$(":input").attr("disabled",false).removeClass("bgcol");
				$("#btnRegister").attr("disabled", false);
			}
		});// end of $("#passwd").blur()----------------------

		$("#pwdcheck").blur(function() {
			var pwd = $("#pwd").val();
			var pwdcheck = $(this).val();

			if (pwd != pwdcheck) {
				$(this).next().show();
				$(":input").attr("disabled", true).addClass("bgcol");
				$(this).attr("disabled", false).removeClass("bgcol");
				$("#pwd").attr("disabled", false).removeClass("bgcol");
				$("#btnRegister").attr("disabled", true);
				$(this).val("");
				$("#pwd").focus();
			} else {
				$(this).next().hide();
				$(":input").attr("disabled", false).removeClass("bgcol");
				$("#btnRegister").attr("disabled",false);
			}
		});// end of $("#passwdcheck").blur()----------------------------------------------------------------------------------

		// === *** 생년 / 월 / 일 유효성 검사 *** ===
			

		// ============================================================= *** email 유효성 검사 *** =================================
		$("#email").blur(function() {
			var email = $(this).val();
			var pattern = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
			var bool = pattern.test(email);

			if (!bool) {  //   $(this).parent().find(".error").show();
				$(this).next().show();
				$(":input").attr("disabled",true).addClass("bgcol");
				$(this).attr("disabled", false).removeClass("bgcol");
				$("#btnRegister").attr("disabled", true);
				$(this).val("");
				$(this).focus();
			} else {
				$(this).next().hide();
				$(":input").attr("disabled",false).removeClass("bgcol");
				$("#btnRegister").attr("disabled", false);
			}
		});// end of $("#email").blur()----------------------	   

		$("#hp2").blur(function() {
			var hp2 = $(this).val();
			if (hp2 != "") {  //  var pattern = new RegExp(/\d{3,4}/g);   
				var pattern = /\d{3,4}/g;  // 숫자만 체크 정규식 최소3자리, 최대4자리
				var bool = pattern.test(hp2);
				
				if (!bool) {
					$(".error_hp").show();
					$(":input").attr("disabled", true).addClass("bgcol");
					$(this).attr("disabled", false).removeClass("bgcol");
					$("#hp1").attr("disabled", false).removeClass("bgcol");
					$("#hp3").attr("disabled", false).removeClass("bgcol");
					$("#btnRegister").attr("disabled",true);
					$(this).val("");
					$(this).focus();
				} else {
					$(".error_hp").hide();
					$(":input").attr("disabled", false).removeClass("bgcol");
					$("#btnRegister").attr("disabled",false);
				}
			} else {
				$(".error_hp").hide();
			}
		});// end of $("#hp2").blur()----------------------   

		$("#hp3").blur(function() {

			var hp3 = $(this).val();

			if (hp3 != "") {
				//  var pattern = new RegExp(/\d{4}/g);   
				var pattern = /\d{4}/g;
				// 숫자만 체크 정규식 숫자 4자리

				var bool = pattern.test(hp3);

				if (!bool) {

					$(".error_hp").show();

					$(":input").attr("disabled", true).addClass("bgcol");
					$(this).attr("disabled", false).removeClass("bgcol");
					$("#hp1").attr("disabled", false).removeClass("bgcol");
					$("#hp2").attr("disabled", false).removeClass("bgcol");

					$("#btnRegister").attr("disabled", true);

					$(this).val("");
					$(this).focus();
				} else {
					$(".error_hp").hide();

					$(":input").attr("disabled", false).removeClass("bgcol");
					$("#btnRegister").attr("disabled", false);
				}
			} else if ($("#hp2").val() != "" && hp3 == "") {
				$(".error_hp").show();

				$(":input").attr("disabled", true).addClass("bgcol");
				$(this).attr("disabled", false).removeClass("bgcol");
				$("#hp1").attr("disabled", false).removeClass("bgcol");
				$("#hp2").attr("disabled", false).removeClass("bgcol");

				$("#btnRegister").attr("disabled", true);

				$(this).val("");
				$(this).focus();
			} else if ($("#hp2").val() == "" && hp3 == "") {
				$(".error_hp").hide();

				$(":input").attr("disabled", false).removeClass("bgcol");
				$("#btnRegister").attr("disabled", false);
			}

		});// end of $("#hp3").blur()----------------------

		$("#post1").blur(function() {
			var post1 = $(this).val();

			if (post1 != "") {
				//  var pattern = new RegExp(/\d{3}/g);   
				var pattern = /\d{3}/g;
				// 숫자만 체크 정규식 숫자 3자리

				var bool = pattern.test(post1);

				if (!bool) {
					$(".error_post").show();

					$(":input").attr("disabled", true).addClass("bgcol");
					$(this).attr("disabled", false).removeClass("bgcol");
					$("#post2").attr("disabled", false).removeClass("bgcol");

					$("#btnRegister").attr("disabled", true);

					$(this).val("");
					$(this).focus();
				} else {
					$(".error_post").hide();

					$(":input").attr("disabled", false).removeClass("bgcol");
					$("#btnRegister").attr("disabled", false);
				}
			} else {
				$(".error_post").hide();
			}
		});// end of $("#post1").blur()----------------------   

		$("#post2").blur(function() {
			var post2 = $(this).val();

			if (post2 != "") {
				//  var pattern = new RegExp(/\d{3}/g);   
				var pattern = /\d{3}/g;
				// 숫자만 체크 정규식 숫자 3자리

				var bool = pattern.test(post2);

				if (!bool) {
					$(".error_post").show();

					$(":input").attr("disabled", true).addClass("bgcol");
					$(this).attr("disabled", false).removeClass("bgcol");
					$("#post1").attr("disabled", false).removeClass("bgcol");

					$("#btnRegister").attr("disabled", true);

					$(this).val("");
					$(this).focus();
				} else {
					$(".error_post").hide();

					$(":input").attr("disabled", false).removeClass("bgcol");
					$("#btnRegister").attr("disabled", false);
				}
			} else if ($("#post1").val() != "" && post2 == "") {
				$(".error_post").show();

				$(":input").attr("disabled", true).addClass("bgcol");
				$(this).attr("disabled", false).removeClass("bgcol");
				$("#post1").attr("disabled", false).removeClass("bgcol");

				$("#btnRegister").attr("disabled", true);

				$(this).val("");
				$(this).focus();
			} else if ($("#post1").val() == "" && post2 == "") {
				$(".error_post").hide();

				$(":input").attr("disabled", false).removeClass("bgcol");
				$("#btnRegister").attr("disabled", false);
			}
		});// end of $("#post2").blur()----------------------

		$("#userid").bind("keyup", function() {
			alert("ID검사 버튼을 클릭하여 ID중복 검사를 하십시오.");
			$(this).val("");
		});// end of $("#userid").bind()----------------------

		$("#idcheck").click(function() {
			// 팝업창 띄우기
			window.open("member_idDuplicateCheck.mr", "idcheck", "left=500px; top=100px; width=300px; height=200px;");
		});
	}); // end of $(document).ready()------------------

	function goRegister(event) {

		var flagBool = false;

		$(".requiredInfo").each(function() {
			var data = $(this).val().trim();
			if (data.length == 0) {
				flagBool = true;
				return false;
			}
		});

		if (flagBool) {
			alert("필수입력란은 모두 입력하셔야 합니다.");
			event.preventDefault();
		} else if (!$("#agree").is(":checked")) {
			alert("이용약관에 동의하셔야 합니다.");
			event.preventDefault();
		} else {
			var frm = document.registerFrm;
			frm.method = "post";
			frm.action = "member_registerEnd.mr";
			frm.submit();
		}

	}// end of goRegister(event)-----------------------

	function openDaumPostnum() {
		new daum.Postcode({
			oncomplete : function(data) {
				document.getElementById("post1").value = data.postcode1;
				document.getElementById("post2").value = data.postcode2;
				document.getElementById("addr1").value = data.address;
				document.getElementById("addr2").focus();
			}
		}).open();
	}// end of function openDaumPostnum()-----------------
</script>

</head>


<body background="<%= request.getContextPath() %>/resources/images/loginbg.png">
	<div align="center" style="width: 100%; border: 2px dotted pink;">
		<div style="width: 600px; border: 2px solid #578CA9; background-color: #4F84C4; border-radius: 15px; margin-top: 20px; margin-bottom: 10px; padding: 10px;">
		<form name="registerFrm">
		<%-- 
			<fieldset>	
				<!-- Form Name -->
				<legend style="padding-bottom: 5px;">회원가입</legend>
				<div style="border: 1px dotted blue; width: 520px; margin-top: 5px; margin-bottom: 5px;">
					<!-- 회원가입 폼 부트스닙스 -->
					
					<div class="form-group">
	
					  <label class="col-sm-4 control-label" for="name">성명 &nbsp;<span class="star">*</span></label>  
					  <div class="col-sm-4">
					  	<input id="name" name="name" type="text" placeholder="name" class="form-control input-sm requiredInfo">
					  	<input type="hidden" name="idx" />
					  </div>
					</div><br/>
					
					<div class="form-group">
					  <label class="col-sm-4 control-label" for="userid">아이디 &nbsp;<span class="star">*</span></label>  
					  <div class="col-sm-4">
					  	<input id="userid" name="userid" type="text" class="form-control input-sm requiredInfo form-inline" placeholder="user-ID">  
					  </div>
					  <!-- 아이디중복체크 --> 
						<a class="btn btn-xs btn-info form-inline" id="idcheck" style="text-align: left;">
							<span style="color: white; font-size: 10pt; vertical-align: middle;">ID검사</span>
						</a> 
						<span class="error">아이디는 필수입력 사항입니다.</span>
					</div><br/>
					
					<div class="form-group">
					  <label class="col-sm-4 control-label" for="pwd">비밀번호 &nbsp;<span class="star">*</span></label>
					  <div style="vertical-align: top; height: 27px;" class="col-sm-7">
					    <input id="pwd" name="pwd" type="password" placeholder="password" class="form-control input-sm requiredInfo" required >
					  </div>
					</div><br/>
					<div class="form-group">
					  <label class="col-sm-4 control-label" for="pwdcheck">비밀번호 확인 <span class="star">*</span></label>
					  <div style="vertical-align: top; height: 27px;" class="col-sm-7">
					    <input id="pwdcheck" name="pwdcheck" type="password" placeholder="password-check" class="form-control input-sm requiredInfo" required >
					  </div>
					</div><br/>
					
					<div class="form-group">
					  <label class="col-sm-4 control-label" for="birth">생년월일 &nbsp;<span class="star">*</span></label>  
					  <div class="form-inline col-sm">
					  	<input style="vertical-align: top; height: 25px;" id="birth1" name="birth1" type="text" placeholder="yy" size="2" maxlength="2" class="form-inline form-control input-sm" > / 
					  	<input style="vertical-align: top; height: 25px;" id="birth2" name="birth2" type="text" placeholder="mm" size="2" maxlength="2" class="form-inline form-control input-sm" > /
					  	<input style="vertical-align: top; height: 25px;" id="birth3" name="birth3" type="text" placeholder="dd" size="2" maxlength="2" class="form-inline form-control input-sm" >
					  </div>
					</div><br/>
					
					<div class="form-group">
					  <label class="col-sm-4 control-label" for="email">이메일 &nbsp;<span class="star">*</span></label>  
					  <div class="col-sm-7">
					  	<input style="vertical-align: top; height: 27px;" id="email" name="email" type="text" placeholder="e-mail" class="form-control input-sm requiredInfo" >
					  </div>
					</div><br/>
					
					<div class="form-group form-inline">
					  <label class="form-inline col-sm-4 control-label" for="hp">연락처 &nbsp;<span class="star">*</span></label>
					  <div class="form-inline col-sm">
					    <select id="hp1" name="hp1" class="form-control form-inline" style="height: 27px; font-size: 9pt; vertical-align: top;">
					      <option value="010" selected>010</option>
					      <option value="011">011</option>
					      <option value="016">016</option>
					    </select>
					    <input style="vertical-align: top; height: 27px;" id="hp2" name="hp2" type="text" placeholder="Hp2" size="4" maxlength="4" class="form-inline form-control input-sm"> -
					  	<input style="vertical-align: top; height: 27px;" id="hp3" name="hp3" type="text" placeholder="Hp3" size="4" maxlength="4" class="form-inline form-control input-sm">
					  </div>
					</div><br/>
					
					<div class="form-group form-inline">
					  <label class="col-sm-4 control-label form-inline" for="post">우편번호</label>  
					  <div class="form-inline col-sm">
						  <input style="vertical-align: top; height: 27px;" id="post1" name="post1" type="text" placeholder="Post1" size="3" class="form-inline form-control input-sm"> - 
						  <input style="vertical-align: top; height: 27px;" id="post2" name="post2" type="text" placeholder="Post2" size="3" class="form-inline form-control input-sm"> &nbsp;&nbsp;
						  <!-- 우편번호 찾기 -->
					      <a style="height: 25px; vertical-align: middle;" class="btn btn-xs btn-info form-inline" onClick="openDaumPostnum();">
					      	<span style="color: white; font-variant: small-caps; font-size: 10pt; vertical-align: text-bottom;">우편번호검색</span>
					      </a>
					  </div>
					</div><br/>
					
					<div class="form-group">
					  <label class="col-sm-4 control-label" for="addr1">기본주소</label>  
					  <div class="col-sm-8">
					  	<input id="addr1" name="addr1" type="text" placeholder="기본주소" class="form-control input-sm">  
					  </div>
					</div><br/>
					<div class="form-group">
					  <label class="col-sm-4 control-label" for="addr2">상세주소</label>  
					  <div class="col-sm-8">
					  	<input id="addr2" name="addr2" type="text" placeholder="상세주소" class="form-control input-sm">  
					  </div>
					</div><br/>
					
					<div class="form-group" align="center" style="margin-left: 10px;">
						
						<iframe src="<%=request.getContextPath()%>/resources/agree/agree.html" width="480px" height="130px;" class="box"></iframe>
						<br/>
						<input type="checkbox" id="agree" />
						<span>이용약관 수칙을 읽었으며 이에 동의합니다.</span>
					</div>
					
					<br/>
					<div>
						<a class="btn btn-sm btn-success" onClick="goRegister(event);">
							<span style="color: white; font-size: 12pt;"> 회원가입 </span>
						</a> &nbsp;&nbsp; 
						<a class="btn btn-sm btn-danger" href="<%=request.getContextPath()%>/member_login.mr">
							<span style="color: white; font-size: 12pt;"> 로그인화면 </span>
						</a>
					</div>
				</div>
			</fieldset>
			 --%>
 
			<table id="tblMemberRegister" style="margin-bottom: 30px;">
				<thead>
					<tr>
						<th colspan="2" id="th">회원 가입 (
							<span style="font-size: 10pt; font-style: !important; color: blue;"><span class="star"> *</span> 항목 기입 필수 </span>)
						</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 200px; font-weight: bold;">성명&nbsp;
							<span class="star">*</span>
						</td>
						<td style="width: 400px; text-align: left;">
							<input type="text" id="name" name="name" class="requiredInfo" required />
							<span class="error">성명은 필수입력 사항입니다.</span>
						</td>
					</tr>
					<tr>
						<td style="width: 200px; font-weight: bold;">아이디&nbsp;
							<span class="star">*</span>
						</td>
						<td style="width: 400px; text-align: left;">
							<input type="text" id="userid" name="userid" class="requiredInfo" required />&nbsp;&nbsp;
							<!-- 아이디중복체크 --> 
							<a class="btn btn-xs btn-warning" id="idcheck">
								<span style="color: #4F84C4;"><span class="glyphicon glyphicon-ok-circle"></span> ID검사</span>
							</a> 
							<span class="error">아이디는 필수입력 사항입니다.</span>
						</td>
					</tr>
					<tr>
						<td style="width: 200px; font-weight: bold;">비밀번호&nbsp;<span
							class="star">*</span></td>
						<td style="width: 400px; text-align: left;"><input
							type="password" id="pwd" name="pwd" class="requiredInfo" required />
							<span class="error">암호는 영문자, 숫자, 특수기호가 혼합된 8~15글자로만
								입력가능합니다.</span></td>
					</tr>
					<tr>
						<td style="width: 200px; font-weight: bold;">비밀번호확인&nbsp;<span
							class="star">*</span></td>
						<td style="width: 400px; text-align: left;">
						<input type="password" id="pwdcheck" class="requiredInfo" required />
						<span class="error">비밀번호가 일치하지 않습니다.</span></td>
					</tr>
					<!-- 생년/월/일 추가 -->
					<tr>
						<td style="width: 200px; font-weight: bold;">생년/월/일&nbsp;
						<span class="star">*</span></td>
						<td style="width: 400px; text-align: left;">
						<input type="text" id="birth1" name="birth1" size="2" maxlength="2" />&nbsp;/&nbsp;
						<input type="text" id="birth2" name="birth2" size="2" maxlength="2" />&nbsp;/&nbsp; 
						<input type="text" id="birth3" name="birth3" size="2" maxlength="2" />
						<span class="error error_birth">생년월일 형식이 아닙니다.</span></td>
					</tr>
					<tr>
						<td style="width: 200px; font-weight: bold;">이메일&nbsp;
						<span class="star">*</span></td>
						<td style="width: 400px; text-align: left;">
						<input type="text" id="email" name="email" class="requiredInfo" placeholder="abc123@naver.com" required />
						<span class="error">이메일형식에 맞지 않습니다.</span></td>
					</tr>
					<tr>
						<td style="width: 200px; font-weight: bold;">휴대폰</td>
						<td style="width: 400px; text-align: left;">
							<select id="hp1" name="hp1">
									<option value="010" selected>010</option>
							</select>&nbsp;-&nbsp; <input type="text" id="hp2" name="hp2" size="4" maxlength="4" />&nbsp;-&nbsp;
							<input type="text" id="hp3"name="hp3" size="4" maxlength="4" />
							<span class="error error_hp">휴대폰 형식이 아닙니다.</span>
						</td>
					</tr>
					<tr>
						<td style="width: 200px; font-weight: bold;">우편번호</td>
						<td style="width: 400px; text-align: left;">
						<input type="text" id="post1" name="post1" size="4" maxlength="3" />&nbsp;-&nbsp;
						<input type="text" id="post2" name="post2" size="4" maxlength="3" />&nbsp;&nbsp;
						<!-- 우편번호찾기 --> 
						<a class="btn btn-xs btn-warning" onClick="openDaumPostnum();">
							<span style="color: #4F84C4;"><span class="glyphicon glyphicon-ok-circle"></span> 우편번호검색</span>
						</a> 
						<span class="error error_post">우편번호 형식이 아닙니다.</span></td>
					</tr>
					<tr>
						<td style="width: 200px; font-weight: bold;">주소</td>
						<td style="width: 400px; text-align: left;">
						<input type="text" id="addr1" name="addr1" size="60" maxlength="150" /><br style="line-height: 200%" />
						<input type="text" id="addr2" name="addr2" size="60" maxlength="150" /></td>
					</tr>
					<tr>
						<td colspan="2"><label for="agree">이용약관에 동의합니다</label>&nbsp;
						<input type="checkbox" id="agree" /></td>
					</tr>
					<tr>
						<td colspan="2"style="text-align: center; vertical-align: middle;">
							<iframe src="<%=request.getContextPath()%>/resources/agree/agree.html" width="88%" height="150px;" class="box"></iframe>
							<br /><br />
						</td>
					</tr>
					<tr>
						<td colspan="2" style="text-align: center; vertical-align: middle;">
							<a class="btn btn-sm btn-success" onClick="goRegister(event);">
								<span style="color: white; font-size: 14pt;"><span class="glyphicon glyphicon-check"></span> 회원가입 </span>
							</a> &nbsp;&nbsp; 
							<a class="btn btn-sm btn-danger" href="<%=request.getContextPath()%>/member_login.mr">
								<span style="color: white; font-size: 14pt;">
								<span class="glyphicon glyphicon-remove"></span> 로그인화면으로 </span>
							</a>
							<br /><br />
						</td>
					</tr>
				</tbody>
			</table>
			
		</form>
		</div>
	</div>

</body>