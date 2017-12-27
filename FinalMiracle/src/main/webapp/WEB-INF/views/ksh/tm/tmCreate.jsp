<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Miracle_회원가입</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/BootStrapStudy/css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery-2.0.0.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/BootStrapStudy/js/bootstrap.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<style>
.content {
	border-radius: 15px;
	background-color: #4F84C4;
	width: 50%;
	margin-top: 13%;
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
			swal("필수입력란은 모두 입력하셔야 합니다.", '', 'info');
			event.preventDefault();
		} else {
			swal({
			  title: "팀 생성 여부",
			  text: "팀 생성을 하시겠습니까?",
			  type: "warning",
			  showCancelButton: true,
			  confirmButtonClass: "btn-success",
			  confirmButtonText: "생성",
			  cancelButtonText: "취소",
			  closeOnConfirm: false,
			  closeOnCancel: true
			},
			function(isConfirm) {
			  if (isConfirm) {
				var frm = document.createFrm;
				frm.method = "post";
				frm.action = "tmCreateEnd.mr";
				frm.submit();
			  }
			});
			
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
	
	function fileCheck(obj) {
		pathpoint = obj.value.lastIndexOf('.');
		filepoint = obj.value.substring(pathpoint+1,obj.length);
		filetype = filepoint.toLowerCase();
		
		if(filetype=='jpg' || filetype=='gif' || filetype=='png' || filetype=='jpeg' || filetype=='bmp') {
			// 정상적인 이미지 확장자 파일일 경우 ...
		} else {
			swal('이미지 파일만 선택할 수 있습니다.', '', 'info');
			parentObj = obj.parentNode
			node = parentObj.replaceChild(obj.cloneNode(true),obj);
			return false;
		}
		
		if(filetype=='bmp') {
			upload = confirm('BMP 파일은 웹상에서 사용하기엔 적절한 이미지 포맷이 아닙니다.\n그래도 계속 하시겠습니까?');
			
			if(!upload) return false;
		}
	}


</script>

</head>


<body background="<%= request.getContextPath() %>/resources/images/loginbg.png">
	<div class="content" style="width: 38%; font-family: verdana; vertical-align: middle; margin-top: 15%; margin-left: 30%;" align="center">
		<form name="createFrm" enctype="multipart/form-data">
			<table id="tblMemberRegister" style="margin-bottom: 30px;">
				<thead>
					<tr>
						<th colspan="2" id="th" style="text-align: center; font-size: 14pt; padding: 5pt; border-radius: 5px;">팀 생성 (
						<span style="font-size: 10pt; font-style: !important; color: blue;">
							<span class="star"> *</span> 항목 기입 필수 </span>)
						</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 35%; font-weight: bold;">팀명&nbsp;<span class="star">*</span></td>
						<td style="width: 65%; text-align: left;">
							<div style="float: left;">
								<input type="text" id="name" name="name" class="form-control requiredInfo" maxlength="20" required />
								<span class="error">팀 명은 필수입력 사항입니다.</span>
							</div>
						</td>
					</tr>
					<tr>
						<td style="width: 35%; font-weight: bold;">연락처</td>
						<td style="width: 65%; text-align: left;">
							<div style="float: left; width: 25%">
								<select id="hp1" name="hp1" class="form-control">
									<option value="010" selected>010</option>
								</select>
								
							</div>
							<div style="float: left; width: 4%" align="center">
								-
							</div>
							<div style="float: left; width: 25%">
								<input type="text" id="hp2" name="hp2" size="4" maxlength="4" class="form-control" />
							</div>
							<div style="float: left; width: 4%" align="center">
								-
							</div>
							<div style="float: left; width: 25%">
								<input type="text" id="hp3" name="hp3" size="4" maxlength="4" class="form-control" /> 
							</div>
							<br/>
							<div style="float: left;">
								<span class="error error_hp">연락처 형식이 아닙니다.</span>
							</div>
						</td>
					</tr>
					<tr>
						<td style="width: 35%; font-weight: bold;">이미지(로고)</td>
						<td style="width: 65%; text-align: left;">
							<input type="file" name="attach" class="form-control" style="width: 80%;" onchange="fileCheck(this)" accept="image/gif, image/jpg, image/jpeg, image/png" />
						</td>
					</tr>
					<tr>
						<td style="width: 35%; font-weight: bold;">우편번호</td>
						<td style="width: 65%; text-align: left;">
							<div style="float: left; width: 20%">
								<input type="text" id="post1" name="post1" size="4" maxlength="3" class="form-control" />
							</div>
							<div style="float: left; width: 5%" align="center">
								&nbsp;-&nbsp;
							</div>
							<div style="float: left; width: 20%">
								<input type="text" id="post2" name="post2" size="4" maxlength="3" class="form-control" />
							</div>
							<div style="float: left; width: 5%" align="center">
								&nbsp;&nbsp;
							</div>
							<div style="float: left; width: 15%">
								<!-- 우편번호찾기 --> 
								<a class="btn btn-sm btn-warning" onClick="openDaumPostnum();">
									<span style="color: #4F84C4;"><span class="glyphicon glyphicon-ok-circle"></span> 우편번호검색</span>
								</a> 
							</div>
							<br/>
							<div style="float: left;">
								<span class="error error_post"><br/>우편번호 형식이 아닙니다.</span>
							</div>
						</td>	
					</tr>
					<tr>
						<td style="width: 35%; font-weight: bold; vertical-align: top"><br/>주소</td>
						<td style="width: 65%; text-align: left;">
							<input type="text" id="addr1" name="addr1" size="50" maxlength="150" class="form-control" style="width: 80%" />
							<input type="text" id="addr2" name="addr2" size="50" maxlength="150" class="form-control" style="width: 80%" />
						<br/><br/>
						</td>
					</tr>
					<tr>
						<td colspan="2" style="text-align: center; vertical-align: middle; height: 10%;">
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