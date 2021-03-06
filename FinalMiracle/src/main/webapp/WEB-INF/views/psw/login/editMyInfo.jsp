<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<meta charset="UTF-8">

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>


<style type="text/css">

	

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
	
	function openAlterImg() {
		var uri = 'member_alterImg.mr'
	    var width = 350;
	    var height = 200;
	    var top = (screen.availHeight - height) / 2;
	    var left = (screen.availWidth - width) / 2;
	    var strFeature;
	    strFeature = 'height=' + height + ',width=' + width + ',menubar=no,toolbar=no,location=no,resizable=no,status=no,scrollbars=yes,top=' + top + ',left=' + left
	
	    window.open(uri, "alterImg", strFeature);
	}
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

	<div style="width: 100%; border: 2px dotted #F5F5F5; border-radius: 20px; background-color: #F5F5F5; padding: 5px;" align="left">
		<form class="form-inline" name="registerFrm" action="member_editEnd.mr" method="post">
			
			<div style="border: 2px dotted #92a8d1; border-radius: 20px; background-color: #deeaee; padding: 5px; float: right;" align="center">
				<h5 style="font-weight: bold; font-family: verdana;">프로필 이미지</h5>
				<img alt="프로필 이미지" src="<%= request.getContextPath() %>/resources/files/${sessionScope.loginUser.img}" style="height: 130px; width: 120px; padding-bottom: 10px;">
				<br/>
				<a class="btn btn-xs btn-primary" href="javascript:openAlterImg();" style="text-align: center; text-decoration: none; font-family: verdana; cursor: pointer; font-size: 10pt; color: white;">변경하기</a>
			</div>
			
			<div style="border: 2px dotted white; border-radius: 20px; width: 410px; padding: 10px;" align="left">
				<table>
					<!-- 회원정보 수정 폼 부트스닙스 -->
					<tr>
					  <th>성명 &nbsp;<span class="star">*</span></th>
					  <td style="padding: 5px; margin-left: 15px;">
					  	<input id="name" name="name" type="text" placeholder="name" class="form-control input-sm requiredInfo" value="${map.mvo.name}" required >
					  	<input type="hidden" name="idx"  value="${map.mvo.idx}" />
					  </td>
					</tr>
					
					<tr>
					  <th>아이디 &nbsp;<span class="star">*</span></th>  
					  <td style="padding: 5px; margin-left: 15px;">
					  	<input id="userid" name="userid" type="text" class="form-control input-sm requiredInfo" value="${map.mvo.userid}" readonly>  
					  </td>
					</tr>
					
					<tr>
					  <th>비밀번호 &nbsp;<span class="star">*</span></th>
					  <td style="padding: 5px; margin-left: 15px;">
					    <input id="pwd" name="pwd" type="password" placeholder="password" class="form-control input-sm requiredInfo" required >
					  </td>
					</tr>
					
					<tr>
					  <th>비밀번호 확인 <span class="star">*</span></th>
					  <td style="padding: 5px; margin-left: 15px;">
					    <input id="pwdcheck" name="pwdcheck" type="password" placeholder="password-check" class="form-control input-sm requiredInfo" required >
					  </td>
					</tr>
					
					<tr>
					  <th>생년월일 &nbsp;<span class="star">*</span></th>  
					  <td style="padding: 5px; margin-left: 15px;">
					  	<input style="vertical-align: top; height: 27px;" id="birth1" name="birth1" type="text" placeholder="YY" size="2" maxlength="2" class="form-inline form-control input-sm" value="${map.mdvo.birth1}" required> / 
					  	<input style="vertical-align: top; height: 27px;" id="birth2" name="birth2" type="text" placeholder="MM" size="2" maxlength="2" class="form-inline form-control input-sm" value="${map.mdvo.birth2}" required> /
					  	<input style="vertical-align: top; height: 27px;" id="birth3" name="birth3" type="text" placeholder="DD" size="2" maxlength="2" class="form-inline form-control input-sm" value="${map.mdvo.birth3}" required>
					  </td>
					</tr>
					
					<tr>
					  <th>이메일 &nbsp;<span class="star">*</span></th>  
					  <td style="padding: 5px; margin-left: 15px;">
					  	<input style="vertical-align: top; height: 27px;" id="email" name="email" type="text" placeholder="이메일" class="form-control input-sm requiredInfo" value="${map.mdvo.email}" required>
					  </td>
					</tr>
					
					<tr>
					  <th>연락처 &nbsp;<span class="star">*</span></th>
					  <td style="padding: 5px; margin-left: 15px;">
					    <select id="hp1" name="hp1" class="form-control" style="height: 27px; font-size: 9pt; vertical-align: top;">
					      <option value="010" selected>010</option>
					      <option value="011">011</option>
					      <option value="016">016</option>
					    </select> -
					    <input style="vertical-align: top; height: 27px;" id="hp2" name="hp2" type="text" placeholder="Hp2" size="3" maxlength="4" class="form-control input-sm" value="${map.mdvo.hp2}"> -
					  	<input style="vertical-align: top; height: 27px;" id="hp3" name="hp3" type="text" placeholder="Hp3" size="3" maxlength="4" class="form-control input-sm" value="${map.mdvo.hp3}">
					  </td>
					</tr>
					
					<tr>
					  <th>우편번호</th>  
					  <td style="padding: 5px; margin-left: 15px;">
						  <input style="vertical-align: top; height: 27px;" id="post1" name="post1" type="text" placeholder="Post1" size="3" class="form-control input-sm" value="${map.mdvo.post1}" required> - 
						  <input style="vertical-align: top; height: 27px;" id="post2" name="post2" type="text" placeholder="Post2" size="3" class="form-control input-sm" value="${map.mdvo.post2}" required> &nbsp;&nbsp;
						  <!-- 우편번호 찾기 -->
					      <a style="vertical-align: middle;" class="btn btn-xs btn-info form-inline" onClick="openDaumPostnum();">
					      	<span style="color: white; font-size: 10pt; vertical-align: text-bottom;">우편번호검색</span>
					      </a>
					  </td>
					</tr>
					
					<tr>
					  <th>기본주소</th>  
					  <td style="padding: 5px; margin-left: 15px;" >
					  	<input id="addr1" name="addr1" type="text" placeholder="기본주소" class="form-control input-sm" style="width: 250px; font-size: 9pt;" value="${map.mdvo.addr1}" required>  
					  </td>
					</tr>
					
					<tr>
					  <th>상세주소</th>  
					  <td style="padding: 5px; margin-left: 15px;">
					  	<input id="addr2" name="addr2" type="text" placeholder="상세주소" class="form-control input-sm" style="width: 250px; font-size: 9pt;" value="${map.mdvo.addr2}" required>  
					  </td>
					</tr>
					
					<tr>
					  <th>프로필</th>
					  <td style="padding: 5px; margin-left: 15px;">                     
					    <textarea class="form-control" id="profile" name="profile" style="height: 100px; width: 250px; font-size: 9pt; resize: none;">${map.mdvo.profile}</textarea>
					  </td>
					</tr>
				</table>
				
				<div align="center" style="margin-top: 10px;">
					<a class="btn btn-sm btn-success" id="btnEdit" onClick="goEditEnd();"><span style="color: white; font-family: verdana; font-size: 11pt;">내정보 변경</span></a>
				</div>
	 		</div>		
			
			
		</form>
	</div> 
	
</c:if>












