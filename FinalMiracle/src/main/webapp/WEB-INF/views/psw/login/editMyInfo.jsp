<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<meta charset="UTF-8">

<style type="text/css">
	.edit {display: inline-block;}
	
	.edit.img{border: 3px solid red;
			  margin-top: 5%;}
	
	.edit.info{border: 2px solid green;}
	
	.error { color: red; padding-left: 10px; margin-bottom: 5px;}
	
	.bgcol {background-color: LightGray;}
</style>

<script type="text/javascript">

	$(document).ready(function(){
		$(".error").hide();
		
		$(".requiredInfo").each(function(){
			$(this).blur(function(){
				var data = $(this).val().trim(); 
				if(data.length == 0) {
				    $(this).next().show(); 
				    $(":input").attr('disabled', true).addClass('bgcol'); 
				    $(this).attr('disabled', false).removeClass('bgcol');
				    $("#btnEdit").attr('disabled', true);
				    $(this).focus();
				} else {
	                $(this).next().hide(); 
	                $(":input").attr('disabled', false).removeClass('bgcol'); 
				    $("#btnEdit").attr('disabled', false);
				}
			});
		});// end of $(".requiredInfo").each();-------------------------------------------------
		
		// ==================================================== 비밀번호 유효성 검사 ===========================		
		$("#pwd").blur(function(){
    		var pwd = $(this).val(); 
    		var pattern = new RegExp(/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g);
    		// 숫자/문자/특수문자/ 포함 형태의 8~15자리 이내의 암호 정규식 
    		var bool = pattern.test(pwd);
    		
    		if(!bool) {  // 비밀번호 유효성검사가 통과했을 경우 ----------------------------------------
       		 // $(this).parent().find('.error').show();
       			$(this).next().show();
       			$(":input").attr('disabled', true).addClass('bgcol'); 
   			    $(this).attr('disabled', false).removeClass('bgcol');
   			    
   			    $("#btnEdit").attr('disabled', true);
   			    $(this).val("");
   			    $(this).focus();
       		} else if(bool) {  // 비밀번호 유효성 검사가 실패했을경우 ---------------------------------
       			$(this).next().hide();
       			$(":input").attr('disabled', false).removeClass('bgcol'); 
   			    $("#btnEdit").attr('disabled', false);
       		}
       	});  // end of $("#pwd").blur();-----------------
    	
    	
    	$("#pwdcheck").blur(function(){ 
    		var pwd = $("#pwd").val();
    		var pwdcheck = $("#pwdcheck").val();
    		
    		if(pwd != pwdcheck) {  // 암호값 != 암호확인값 ------------------------------------------------
       			$(this).next().show();
       			$(":input").attr('disabled', true).addClass('bgcol'); 
   			    $(this).attr('disabled', false).removeClass('bgcol');
   			    $("#pwd").attr('disabled', false).removeClass('bgcol');
   			    $("#btnEdit").attr('disabled', true);
   			    $("#pwd").val("");
   			    $(this).val("");
   			    $("#pwd").focus();
       		} else {  // 암호값 = 암호확인값 ---------------------------------------------------------------
       			$(this).next().hide(); 
                $(":input").attr('disabled', false).removeClass('bgcol'); 
   			    $("#btnEdit").attr('disabled', false);
       		}
       	});  // end of $("#passwdCheck").blur();----------------------------------------------------------
    	
    	// ================================================ *** 이메일 유효성 검사 *** ===============================================
		$("#email").blur(function(){
    		var email = $("#email").val();
    		var pattern = new RegExp(/^[0-9a-zA-Z]([\-.\w]*[0-9a-zA-Z\-_+])*@([0-9a-zA-Z][\-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9}$/g); 
    		// 이메일을 검사하는 정규표현식 
    		var bool = pattern.test(email);
    		
    		if(!bool) {
       			$(this).next().show();
       			$(":input").attr('disabled', true).addClass('bgcol'); 
   			    $(this).attr('disabled', false).removeClass('bgcol');
   			    $("#btnEdit").attr('disabled', true);
   			    $(this).val("");
   			    $(this).focus(); 
       		} else {
       			$(this).next().hide();
       			$(":input").attr('disabled', false).removeClass('bgcol'); 
   			    $("#btnEdit").attr('disabled', false);
       		}
       	});  // end of $("#email").blur()--------------------
    	
    	// ================================================= *** 전화번호(hp2, hp3) 유효성 검사 *** ===================================
    	$("#hp2").blur(function(){
    		var hp2 = $(this).val();
    		
    		if(hp2 != "") {
    			var pattern1 = new RegExp(/^(\d+)$/g);
    			// 숫자만 입력할 수 있음
    			var pattern2 = new RegExp(/\d{3,4}/g);
	    		// 숫자만 체크 정규식  최소 3자리 , 최대 4자리
    			var bool1 = pattern1.test(hp2);
    			var bool2 = pattern2.test(hp2);
    		
    			if(!(bool1 && bool2)) {
    				$(".error_hp").show();
    				$(":input").attr('disabled', true).addClass('bgcol'); 
			    	$(this).attr('disabled', false).removeClass('bgcol');
			   	 	$("#hp1").attr('disabled', false).removeClass('bgcol');
			    	$("#hp3").attr('disabled', false).removeClass('bgcol');
			    	$("#btnEdit").attr('disabled', true);
			    	$(this).val("");
				    $(this).focus();    
    			} else {
    				$(".error_hp").hide();
    				$(":input").attr('disabled', false).removeClass('bgcol'); 
			    	$("#btnEdit").attr('disabled', false);
    			}
    		} else {
    			$(".error_hp").hide();
    		}
    	});  // end of $("#hp2").blur() ----------------------------------------------------------------
		
    	$("#hp3").blur(function(){
			var hp3 = $(this).val();
    		
    		if(hp3 != "") {
	    		var pattern = new RegExp(/\d{4}/g);
	    		// 숫자만 체크 정규식, 숫자4자리
    			var bool = pattern.test(hp3);
    		
    			if(!bool) {
    				$(".error_hp").show();
    				$(":input").attr('disabled', true).addClass('bgcol'); 
			    	$(this).attr('disabled', false).removeClass('bgcol');
			    	$("#hp1").attr('disabled', false).removeClass('bgcol');
			    	$("#hp2").attr('disabled', false).removeClass('bgcol');
			    	$("#btnEdit").attr('disabled', true);
			    	$(this).val("");
				    $(this).focus();
    			} else {
    				$(".error_hp").hide();
    				$(":input").attr('disabled', false).removeClass('bgcol'); 
			    	$("#btnEdit").attr('disabled', false);
    			}
    		} else if($("#hp2").val() != "" && hp3 == "" ) {
	    			$(".error_hp").show();
					$(":input").attr('disabled', true).addClass('bgcol'); 
			    	$(this).attr('disabled', false).removeClass('bgcol');
			    	$("#hp1").attr('disabled', false).removeClass('bgcol');
			    	$("#hp2").attr('disabled', false).removeClass('bgcol');
			    	$("#btnEdit").attr('disabled', true);
			    	$(this).val("");
				    $(this).focus();
    		} else if($("#hp2").val() == "" && hp3 == "" ) {
    				$(".error_hp").hide();
    				$(":input").attr('disabled', false).removeClass('bgcol'); 
			    	$("#btnEdit").attr('disabled', false);
    		}
    	});  // end of $("#hp3").blur() -----------------------------------------------------------------------
    	
    	
    	// ========================================================== *** 우편번호(post1, post2) 유효성 검사 *** ============
     	$("#post1").blur(function(){
    		var post1 = $(this).val();
    		
    		if(post1 != "") {
	    		var pattern = new RegExp(/\d{3}/g);  // 숫자만 체크 정규식, 숫자3자리
	    		var bool = pattern.test(post1);
	    		
	    		if(!bool) {
	    			$(".error_post").show();
	    			$(":input").attr('disabled', true).addClass('bgcol'); 
				    $(this).attr('disabled', false).removeClass('bgcol');
				    $("#post2").attr('disabled', false).removeClass('bgcol');
				    $("#btnEdit").attr('disabled', true);
				    $(this).val("");
				    $(this).focus();
	    		} else {
	    			$(".error_post").hide();
	    			$(":input").attr('disabled', false).removeClass('bgcol'); 
				    $("#btnEdit").attr('disabled', false);
	    		}
    		} else {
    			$(".error_post").hide();
    			$(":input").attr('disabled', false).removeClass('bgcol'); 
			    $("#btnEdit").attr('disabled', false);
    		}
    	});// end of $("#post1").blur()-----------------------------------------------------------------------------------

     	$("#post2").blur(function(){
    		var post2 = $(this).val();
    		
    		if(post2 != "") {
	    		var pattern = new RegExp(/\d{3}/g);
	    		// 숫자만 체크 정규식, 숫자3자리
	    		var bool = pattern.test(post2);
	    		
	    		if(!bool) {
	    			$(".error_post").show();
	    			$(":input").attr('disabled', true).addClass('bgcol'); 
				    $(this).attr('disabled', false).removeClass('bgcol');
				    $("#post1").attr('disabled', false).removeClass('bgcol');
				    $("#btnEdit").attr('disabled', true);
				    $(this).val("");
				    $(this).focus();
	    		} else {
	    			$(".error_post").hide();
	    			$(":input").attr('disabled', false).removeClass('bgcol'); 
				    $("#btnEdit").attr('disabled', false);
	    		}
    		} else if( $("#post1").val() != "" && post2 == "" ) {
    			$(".error_post").show();
    			$(":input").attr('disabled', true).addClass('bgcol'); 
			    $(this).attr('disabled', false).removeClass('bgcol');
			    $("#post1").attr('disabled', false).removeClass('bgcol');
			    $("#btnEdit").attr('disabled', true);
			    $(this).val("");
			    $(this).focus();
    		} else if( $("#post1").val() == "" && post2 == "" ) {
    			$(".error_post").hide();
    			$(":input").attr('disabled', false).removeClass('bgcol'); 
			    $("#btnEdit").attr('disabled', false);
    		}
    	});// end of $("#post2").blur() --------------------------------------------------------------------------------
    	
    	// ======================================================  *** 아이디 중복체크 팝업창 띄우기 *** ==========================
    	$("#idcheck").click(function(){  // 팝업창 띄우기
    		var url = "member_idDuplicateCheck.mr";
    		window.open(url,"idcheck", "left=500px, top=100px, width=300px, height=200px");
    	});
	});// end of $(document).ready()-------------------------------------------------------------------------------------

	// =================================================================== *** JavaScript function *** ==================
	function goEditEnd(event) {
		var flagBool = false;
		
		$(".requiredInfo").each(function(){
			var data = $(this).val().trim();
			if(data.length == 0) {
				flagBool = true;
				return false;
			}
		});
		
		if(flagBool) {
			alert("필수입력란은 모두 입력하셔야 합니다.");
			event.preventDefault(); // click event 를 작동치 못하도록 한다.
		} else {
		   var registerFrm = document.registerFrm; 
		   registerFrm.submit();
		}
	}  // end of goEditEnd(event) ----------------------------------------------------------------------------------------
	
	function openDaumPostnum() {
		new daum.Postcode({
	        oncomplete: function(data) {
	        	document.getElementById("post1").value = data.postcode1;
	        	document.getElementById("post2").value = data.postcode2;
	        	document.getElementById("addr1").value = data.address;
	        	document.getElementById("addr2").focus();           
	        }	
	    }).open();
	}  // end of function openDaumPostnum()---------------------------------------------------------------------------------
</script>


<!-- =================================== *** 회원번호가 없는 경우 *** ======================================================= -->
<c:if test="${empty map}">	
	<div>	
		<span style="color: red; font-weight: bold;">[${idx}]</span>번 회원정보는 존재하지 않습니다.
		<br/><br/>
		[<a href="javascript:self.close();">닫기</a>]
		<%-- javascript:self.close() 이 팝업창을 닫게 하는 것이다. --%>
	</div>
</c:if>

<!-- ====================================================== *** 회원번호가 있는 경우 *** ======================================= -->
<c:if test="${not empty map}">
	<div style="padding-left: 20px;">
		<form name="registerFrm" action="member_editEnd.mr" method="post">
			<input type="hidden" name="currentShowPageNo" value="${currentShowPageNo}"/>
			<input type="hidden" name="sizePerPage" value="${sizePerPage}" />
		
			<div class="edit img" style="float: left;">
				<img alt="프로필사진" src="<%= request.getContextPath() %>/resources/images/${sessionScope.loginUser.img}" style="height: 280px; width: 256px;">
				<br/>
				<a href="#">[대표 이미지 변경]</a>
				<br/><br/>
			</div>
		
			<div class="edit info" style="float: left;">
				<table id="tblMemberRegister">
					<tr>
						<th colspan="2" id="th" style="text-align: center;">내 정보 수정 (<span style="font-size: 10pt; font-style: italic;"><span class="star">*</span>표시는 필수입력사항</span>)</th>
					</tr>
					<tr>
						<td style="width: 25%; font-weight: bold;">성명&nbsp;<span class="star">*</span></td>
						<td style="width: 75%; text-align: left;"><input type="text" name="name" id="name" value="${map.mvo.name}" class="requiredInfo" required />
						                                          <input type="hidden" name="idx"  value="${map.mvo.idx}" /> 
							<span class="error">성명은 필수입력 사항입니다.</span>
						</td>
					</tr>
					<tr>
						<td style="width: 25%; font-weight: bold;">아이디&nbsp;<span class="star">*</span></td>
						<td style="width: 75%; text-align: left;">
						    <input type="text" name="userid" id="userid" value="${map.mvo.userid}" class="requiredInfo" readonly />&nbsp;&nbsp;
						    <span class="error">아이디는 필수입력 사항입니다.</span>
						</td> 
					</tr>
					<!-- ============================================================ *** 암호변경 / 확인 *** ========================================== -->
					<tr>
						<td style="width: 25%; font-weight: bold;">비밀번호&nbsp;<span class="star">*</span></td>
						<td style="width: 75%; text-align: left;">
						    <input type="password" name="pwd" id="pwd" class="requiredInfo" required />
							<span class="error">암호는 영문자,숫자,특수기호가 혼합된 8~15 글자로만 입력가능합니다.</span>
						</td>
					</tr>
					<tr>
						<td style="width: 25%; font-weight: bold;">비밀번호확인&nbsp;<span class="star">*</span></td>
						<td style="width: 75%; text-align: left;">
						    <input type="password" name="pwdcheck" id="pwdcheck" class="requiredInfo" required />
							<span class="error">암호가 일치하지 않습니다.</span>
						</td>
					</tr>
					<!-- ====================================================== *** 생년/월/일 추가 *** ================================================ -->
					<tr>
						<td style="width: 20%; font-weight: bold;">생년/월/일&nbsp;<span class="star">*</span></td>
						<td style="width: 80%; text-align: left;">
						   <input type="text" id="birth1" name="birth1" size="2" maxlength="2" value="${map.mdvo.birth1}" />&nbsp;/&nbsp;
						   <input type="text" id="birth2" name="birth2" size="2" maxlength="2" value="${map.mdvo.birth2}" />&nbsp;/&nbsp;
						   <input type="text" id="birth3" name="birth3" size="2" maxlength="2" value="${map.mdvo.birth3}" /> 
						   <span class="error error_birth">생년월일 형식이 아닙니다.</span> 
						</td>
					</tr>
					<!-- ================================================================ *** 이메일 *** =========================================== -->
					<tr>
						<td style="width: 25%; font-weight: bold;">이메일&nbsp;<span class="star">*</span></td>
						<td style="width: 75%; text-align: left;">
						    <input type="text" name="email" id="email" value="${map.mdvo.email}" class="requiredInfo" required />
						    <span class="error">이메일 형식에 맞지 않습니다.</span>
						</td>
					</tr>
					<!-- ================================================ *** hp1, hp2, hp3 *** ================================================== -->
					<tr>
						<td style="width: 25%; font-weight: bold;">연락처</td>
						<td style="width: 75%; text-align: left;">
						   <select name="hp1" id="hp1">
								<option value="010" selected>010</option>
								<option value="011">011</option>
								<option value="016">016</option>
							</select>&nbsp;-&nbsp;
							
						    <input type="text" name="hp2" id="hp2" value="${map.mdvo.hp2}" size="4" maxlength="4" />&nbsp;-&nbsp;
						    <input type="text" name="hp3" id="hp3" value="${map.mdvo.hp3}" size="4" maxlength="4" />
						    <span class="error error_hp">휴대폰 형식이 아닙니다.</span><br/>
						</td>
					</tr>
					<!-- ===================================================== *** post1, post2 *** ============================================== -->
					<tr>
						<td style="width: 25%; font-weight: bold;">우편번호</td>
						<td style="width: 75%; text-align: left;">
						   <input type="text" name="post1" id="post1" value="${map.mdvo.post1}" size="4" maxlength="3" />-
						   <input type="text" name="post2" id="post2" value="${map.mdvo.post2}" size="4" maxlength="3" />&nbsp;&nbsp;
						   <!-- 우편번호 찾기 -->
						    <a class="btn btn-xs btn-warning" onClick="openDaumPostnum();"><span style="color: #4F84C4;"><span class="glyphicon glyphicon-ok-circle"></span> 우편번호검색</span></a>  
						   <span class="error error_post">우편번호 형식이 아닙니다.</span><br/>
						</td>
					</tr>
					<!-- ===================================================== *** addr1, addr2 *** =============================================== -->
					<tr>
						<td style="width: 25%; font-weight: bold;">주소</td>
						<td style="width: 75%; text-align: left;">
						   <input type="text" name="addr1" id="addr1" value="${map.mdvo.addr1}" size="50" maxlength="100" /><br style="line-height: 200%"/>
						   <input type="text" name="addr2" id="addr2" value="${map.mdvo.addr2}" size="50" maxlength="100" /><br/>
						</td>
					</tr>
					<!-- ================================================================ *** 프로필 *** ============================================= -->
					<tr>
						<th colspan="2" style="text-align: center;">자기소개</th>
					</tr>
					<tr>
						<td colspan="2" style="text-align: center; border: 1px solid orange;">
							<textarea name="profile" class="long" style="width: 300px; height: 120px;">${map.mdvo.profile}</textarea>
						</td>
					</tr>
					<!-- =================================================== *** 내정보 변경 버튼 *** ======================================================= -->
					<tr style="border-left-style: hidden; border-right-style: hidden; border-bottom-style: hidden;">
						<td colspan="2" style="height: 60px; text-align: center; vertical-align: middle;">
							<a class="btn btn-sm btn-success" onClick="goEditEnd();"><span style="color: white;">내정보 변경</span></a>
						</td>
					</tr>
				</table>
			</div>
		</form>
	</div>
	<!-- ======================================================================================================================= -->

</c:if>












