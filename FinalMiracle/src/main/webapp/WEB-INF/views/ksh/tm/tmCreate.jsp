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
	background-color: #4F84C4;
	width: 50%;
	margin-top: 16%;
	margin-left: 25%;
}

table#tblMemberRegister {
	width: 90%;
	border-collapse: collapse;
	margin: 10px;
}

table#tblMemberRegister #th {
	height: 40px;
	text-align: center;
	background-color: silver;
	font-size: 13pt;
}

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
		});
		
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

		$("#hp3").blur(
				function() {

					var hp3 = $(this).val();

					if (hp3 != "") {
						//  var pattern = new RegExp(/\d{4}/g);   
						var pattern = /\d{4}/g;
						// 숫자만 체크 정규식 숫자 4자리

						var bool = pattern.test(hp3);

						if (!bool) {

							$(".error_hp").show();

							$(":input").attr("disabled", true)
									.addClass("bgcol");
							$(this).attr("disabled", false)
									.removeClass("bgcol");
							$("#hp1").attr("disabled", false)
									.removeClass("bgcol");
							$("#hp2").attr("disabled", false)
									.removeClass("bgcol");

							$("#btnRegister").attr("disabled",
									true);

							$(this).val("");
							$(this).focus();
						} else {
							$(".error_hp").hide();

							$(":input").attr("disabled", false)
									.removeClass("bgcol");
							$("#btnRegister").attr("disabled",
									false);
						}
					} else if ($("#hp2").val() != ""
							&& hp3 == "") {
						$(".error_hp").show();

						$(":input").attr("disabled", true)
								.addClass("bgcol");
						$(this).attr("disabled", false)
								.removeClass("bgcol");
						$("#hp1").attr("disabled", false)
								.removeClass("bgcol");
						$("#hp2").attr("disabled", false)
								.removeClass("bgcol");

						$("#btnRegister")
								.attr("disabled", true);

						$(this).val("");
						$(this).focus();
					} else if ($("#hp2").val() == ""
							&& hp3 == "") {
						$(".error_hp").hide();

						$(":input").attr("disabled", false)
								.removeClass("bgcol");
						$("#btnRegister").attr("disabled",
								false);
					}

				});// end of $("#hp3").blur()----------------------

		$("#post1").blur(
				function() {

					var post1 = $(this).val();

					if (post1 != "") {
						//  var pattern = new RegExp(/\d{3}/g);   
						var pattern = /\d{3}/g;
						// 숫자만 체크 정규식 숫자 3자리

						var bool = pattern.test(post1);

						if (!bool) {

							$(".error_post").show();

							$(":input").attr("disabled", true)
									.addClass("bgcol");
							$(this).attr("disabled", false)
									.removeClass("bgcol");
							$("#post2").attr("disabled", false)
									.removeClass("bgcol");

							$("#btnRegister").attr("disabled",
									true);

							$(this).val("");
							$(this).focus();
						} else {
							$(".error_post").hide();

							$(":input").attr("disabled", false)
									.removeClass("bgcol");
							$("#btnRegister").attr("disabled",
									false);
						}
					} else {
						$(".error_post").hide();
					}

				});// end of $("#post1").blur()----------------------   

		$("#post2").blur(
				function() {

					var post2 = $(this).val();

					if (post2 != "") {
						//  var pattern = new RegExp(/\d{3}/g);   
						var pattern = /\d{3}/g;
						// 숫자만 체크 정규식 숫자 3자리

						var bool = pattern.test(post2);

						if (!bool) {

							$(".error_post").show();

							$(":input").attr("disabled", true)
									.addClass("bgcol");
							$(this).attr("disabled", false)
									.removeClass("bgcol");
							$("#post1").attr("disabled", false)
									.removeClass("bgcol");

							$("#btnRegister").attr("disabled",
									true);

							$(this).val("");
							$(this).focus();
						} else {
							$(".error_post").hide();

							$(":input").attr("disabled", false)
									.removeClass("bgcol");
							$("#btnRegister").attr("disabled",
									false);
						}
					} else if ($("#post1").val() != ""
							&& post2 == "") {
						$(".error_post").show();

						$(":input").attr("disabled", true)
								.addClass("bgcol");
						$(this).attr("disabled", false)
								.removeClass("bgcol");
						$("#post1").attr("disabled", false)
								.removeClass("bgcol");

						$("#btnRegister")
								.attr("disabled", true);

						$(this).val("");
						$(this).focus();
					} else if ($("#post1").val() == ""
							&& post2 == "") {
						$(".error_post").hide();

						$(":input").attr("disabled", false)
								.removeClass("bgcol");
						$("#btnRegister").attr("disabled",
								false);
					}

				});// end of $("#post2").blur()----------------------
	
	});
	
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
		} else {
			var frm = document.createFrm;
			frm.method = "post";
			frm.action = "tmCreateEnd.mr";
			frm.submit();
		}

	}
	
	function openDaumPostnum() {
		new daum.Postcode({
			oncomplete : function(data) {
				document.getElementById("post1").value = data.postcode1;
				document.getElementById("post2").value = data.postcode2;
				document.getElementById("addr1").value = data.address;
				document.getElementById("addr2").focus();
			}
		}).open();
	}

</script>

</head>


<body background="<%= request.getContextPath() %>/resources/images/loginbg.png">
	<div class="content" align="center">
		<form name="createFrm" enctype="multipart/form-data">
			<table id="tblMemberRegister" style="margin-bottom: 30px;">
				<thead>
					<tr>
						<th colspan="2" id="th">팀 생성 (<span
							style="font-size: 10pt; font-style: !important; color: blue;"><span
								class="star"> *</span> 항목 기입 필수 </span>)
						</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 20%; font-weight: bold;">팀명&nbsp;<span
							class="star">*</span></td>
						<td style="width: 80%; text-align: left;"><input type="text"
							id="name" name="name" class="requiredInfo" maxlength="20" required /> <span
							class="error">팀 명은 필수입력 사항입니다.</span></td>
					</tr>
					<tr>
						<td style="width: 20%; font-weight: bold;">연락처</td>
						<td style="width: 80%; text-align: left;"><select id="hp1"
							name="hp1">
								<option value="010" selected>010</option>
						</select>&nbsp;-&nbsp; <input type="text" id="hp2" name="hp2" size="4"
							maxlength="4" />&nbsp;-&nbsp; <input type="text" id="hp3"
							name="hp3" size="4" maxlength="4" /> <span
							class="error error_hp">연락처 형식이 아닙니다.</span></td>
					</tr>
					<tr>
						<td style="width: 20%; font-weight: bold;">이미지(로고)</td>
						<td>
							<input type="file" name="attach" />
						</td>
					</tr>
					<tr>
						<td style="width: 20%; font-weight: bold;">우편번호</td>
						<td style="width: 80%; text-align: left;">
						<input type="text" id="post1" name="post1" size="4" maxlength="3" />&nbsp;-&nbsp;
						<input type="text" id="post2" name="post2" size="4" maxlength="3" />&nbsp;&nbsp;

						<!-- 우편번호찾기 --> 
						<a class="btn btn-xs btn-warning" onClick="openDaumPostnum();">
							<span style="color: #4F84C4;"><span class="glyphicon glyphicon-ok-circle"></span> 우편번호검색</span>
						</a> 
						<span class="error error_post">우편번호 형식이 아닙니다.</span></td>
					</tr>
					<tr>
						<td style="width: 20%; font-weight: bold;">주소</td>
						<td style="width: 80%; text-align: left;">
						<input type="text" id="addr1" name="addr1" size="60" maxlength="150" /><br style="line-height: 200%" />
						<input type="text" id="addr2" name="addr2" size="60" maxlength="150" />
						<br/><br/>
						</td>
					</tr>
					<tr>
						<td colspan="2" style="text-align: center; vertical-align: middle;">
							<a class="btn btn-sm btn-success" onClick="goRegister(event);">
								<span style="color: white; font-size: 14pt;"><span class="glyphicon glyphicon-check"></span> 팀 생성 </span>
							</a> &nbsp;&nbsp; 
							<a class="btn btn-sm btn-danger" href="<%=request.getContextPath()%>/tmForm.mr">
								<span style="color: white; font-size: 14pt;">
								<span class="glyphicon glyphicon-remove"></span> 팀 선택 </span>
							</a>
							<br /><br />
						</td>
					</tr>
				</tbody>
			</table>
		</form>

	</div>

</body>