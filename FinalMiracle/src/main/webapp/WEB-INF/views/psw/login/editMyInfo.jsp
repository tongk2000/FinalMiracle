<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<meta charset="UTF-8">

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
				}
				else {
	                $(this).next().hide(); 
	                $(":input").attr('disabled', false).removeClass('bgcol'); 
				    $("#btnEdit").attr('disabled', false);
				}
			});
			
		});// end of $(".requiredInfo").each();------------------
		
		
		$("#pwd").blur(function(){
    		
    		var pwd = $(this).val(); 
    		
    		var pattern = new RegExp(/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g);
    		// 숫자/문자/특수문자/ 포함 형태의 8~15자리 이내의 암호 정규식 
    		
    		var bool = pattern.test(pwd);
    		
    		if(!bool) {
       		 // $(this).parent().find('.error').show();
       			$(this).next().show();
       			$(":input").attr('disabled', true).addClass('bgcol'); 
   			    $(this).attr('disabled', false).removeClass('bgcol');
   			    
   			    $("#btnEdit").attr('disabled', true);
   			    
   			    $(this).val("");
   			    $(this).focus();
       		}
       		else if(bool) {
      			 // $(this).parent().find('.error').hide();
       			$(this).next().hide();
       			$(":input").attr('disabled', false).removeClass('bgcol'); 
   			    
   			    $("#btnEdit").attr('disabled', false);
       		}
       		
       	});// end of $("#pwd").blur();-----------------
    	
    	
    	$("#pwdcheck").blur(function(){ 
    		
    		var pwd = $("#pwd").val();
    		var pwdcheck = $("#pwdcheck").val();
    		
    		if(pwd != pwdcheck) {
       		 // $(this).parent().find('.error').show();
       			$(this).next().show();
       			$(":input").attr('disabled', true).addClass('bgcol'); 
   			    $(this).attr('disabled', false).removeClass('bgcol');
   			    $("#pwd").attr('disabled', false).removeClass('bgcol');
   			    
   			    $("#btnEdit").attr('disabled', true);
   			    
   			    $("#pwd").val("");
   			    $(this).val("");
   			    $("#pwd").focus();
   			    
       		} else {
			
       			$(this).next().hide(); 
                   $(":input").attr('disabled', false).removeClass('bgcol'); 
   			    $("#btnEdit").attr('disabled', false);
       		}
       		
       	});// end of $("#passwdCheck").blur();-----------------
    	
    	
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
       		
       	});// end of $("#email").blur()--------------------
    	
    	
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
    		
    	});// end of $("#hp2").blur()-----------------
    	
    	
    	
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
    		
    	});// end of $("#hp3").blur()-----------------
    	
    	
     	$("#post1").blur(function(){
			
    		var post1 = $(this).val();
    		
    		if(post1 != "") {
    		
	    		var pattern = new RegExp(/\d{3}/g);
	    		// 숫자만 체크 정규식, 숫자3자리
	    		
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
    		
    	});// end of $("#post1").blur()-----------------
    	
    	
    	
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
    		
    	});// end of $("#post2").blur()-----------------
    	
    	
    	$("#idcheck").click(function(){
    		// 팝업창 띄우기
    		var url = "member_idDuplicateCheck.mr";
    		
    		window.open(url,"idcheck",
                        "left=500px, top=100px, width=300px, height=200px");
    	});
	});// end of $(document).ready()----------------
	
	
	
	function goEditEnd(event) {
		
		var flagBool = false;
		
		$(".requiredInfo").each(function(){
			var data = $(this).val().trim();
			if(data.length == 0) {
				flagBool = true;
				// for 문에서의 continue 와 동일한 기능을 하는 것이
				// each(); 내에서는 return true; 이고
				// for 문에서의 break 와 동일한 기능을 하는 것이
				// each(); 내에서는 return false; 이다.
				return false;  // 마치 for문에서의 break; 와 동일한 기능임.
			}
		});
		
		if(flagBool) {
			alert("필수입력란은 모두 입력하셔야 합니다.");
			event.preventDefault(); // click event 를 작동치 못하도록 한다.
		}
		else {
		   var registerFrm = document.registerFrm; 
		   registerFrm.submit();
		}
		
	}  // end of goEditEnd(event) ---------------------
	
	
	function openDaumPostnum() {
		
		new daum.Postcode({
			
	        oncomplete: function(data) {
	            
	        	document.getElementById("post1").value = data.postcode1;
	        	document.getElementById("post2").value = data.postcode2;
	        	document.getElementById("addr1").value = data.address;

	        	document.getElementById("addr2").focus();           
	        }	
		
	    }).open();
		
	}// end of function openDaumPostnum()-----------------
	
	
</script>

<div align="center">

<c:if test="${empty mvo}">		
	<span style="color: red; font-weight: bold;">[${str_idx}]</span>번 회원정보는 존재하지 않습니다.
	<br/><br/>
	[<a href="javascript:self.close();">닫기</a>]
	<%-- javascript:self.close() 이 팝업창을 닫게 하는 것이다. --%>
</c:if>

<c:if test="${not empty mvo }">
	<form name="registerFrm" action="member_EditEnd.mr" method="post">
		<input type="hidden" name="currentShowPageNo" value="${currentShowPageNo}"/>
		<input type="hidden" name="sizePerPage" value="${sizePerPage}" />
	
	<table id="tblMemberRegister">
		<tr>
			<th colspan="2" id="th" style="text-align: center;">회원정보수정 (<span style="font-size: 10pt; font-style: italic;"><span class="star">*</span>표시는 필수입력사항</span>)</th>
		</tr>
		<tr>
			<td style="width: 25%; font-weight: bold;">성명&nbsp;<span class="star">*</span></td>
			<td style="width: 75%; text-align: left;"><input type="text" name="name" id="name" value="${mvo.name}" class="requiredInfo" required />
			                                          <input type="hidden" name="idx"  value="${mvo.idx}" /> 
				<span class="error">성명은 필수입력 사항입니다.</span>
			</td>
		</tr>
		<tr>
			<td style="width: 25%; font-weight: bold;">아이디&nbsp;<span class="star">*</span></td>
			<td style="width: 75%; text-align: left;">
			    <input type="text" name="userid" id="userid" value="${mvo.userid}" class="requiredInfo" readonly />&nbsp;&nbsp;
			    <span class="error">아이디는 필수입력 사항입니다.</span>
			</td> 
		</tr>
		<tr>
			<td style="width: 25%; font-weight: bold;">비밀번호&nbsp;<span class="star">*</span></td>
			<td style="width: 75%; text-align: left;">
			    <input type="password" name="passwd" id="passwd" class="requiredInfo" required />
				<span class="error">암호는 영문자,숫자,특수기호가 혼합된 8~15 글자로만 입력가능합니다.</span>
			</td>
		</tr>
		<tr>
			<td style="width: 25%; font-weight: bold;">비밀번호확인&nbsp;<span class="star">*</span></td>
			<td style="width: 75%; text-align: left;">
			    <input type="password" name="passwdcheck" id="passwdcheck" class="requiredInfo" required />
				<span class="error">암호가 일치하지 않습니다.</span>
			</td>
		</tr>
		<tr>
			<td style="width: 25%; font-weight: bold;">이메일&nbsp;<span class="star">*</span></td>
			<td style="width: 75%; text-align: left;">
			    <input type="text" name="email" id="email" value="${mvo.email}" class="requiredInfo" placeholder="abc123@naver.com" required />
			    <span class="error">이메일 형식에 맞지 않습니다.</span>
			</td>
		</tr>
		<tr>
			<td style="width: 25%; font-weight: bold;">연락처</td>
			<td style="width: 75%; text-align: left;">
			   <select name="hp1" id="hp1">
					<option value="010" selected>010</option>
					<option value="011">011</option>
					<option value="016">016</option>
				</select>&nbsp;-&nbsp;
				
			    <input type="text" name="hp2" id="hp2" value="${mvo.hp2}" size="4" maxlength="4" />&nbsp;-&nbsp;
			    <input type="text" name="hp3" id="hp3" value="${mvo.hp3}" size="4" maxlength="4" />
			    <span class="error error_hp">휴대폰 형식이 아닙니다.</span><br/>
			</td>
		</tr>
		<tr>
			<td style="width: 25%; font-weight: bold;">우편번호</td>
			<td style="width: 75%; text-align: left;">
			   <input type="text" name="post1" id="post1" value="${mvo.post1}" size="4" maxlength="3" />-
			   <input type="text" name="post2" id="post2" value="${mvo.post2}" size="4" maxlength="3" />&nbsp;&nbsp;
			   
			   <!-- 우편번호 찾기 -->
			   <img id="zipcodeSearch" src="<%= request.getContextPath() %>/images/b_zipcode.gif" style="vertical-align: middle;" onClick="openDaumPostnum();" />  
			   <span class="error error_post">우편번호 형식이 아닙니다.</span><br/>
			</td>
		</tr>
		<tr>
			<td style="width: 25%; font-weight: bold;">주소</td>
			<td style="width: 75%; text-align: left;">
			   <input type="text" name="addr1" id="addr1" value="${mvo.addr1}" size="50" maxlength="100" /><br style="line-height: 200%"/>
			   <input type="text" name="addr2" id="addr2" value="${mvo.addr2}" size="50" maxlength="100" />
			</td>
		</tr>
		
		<tr style="border-left-style: hidden; border-right-style: hidden; border-bottom-style: hidden;">
			<td colspan="2" style="height: 60px; text-align: center; vertical-align: middle;">
				<a class="btn btn-md btn-success" onClick="goEditEnd();"><span style="color: white; font-weight: bold; font-size: 12pt;">정보수정</span></a>
			</td>
		</tr>
	</table>
	</form>

</c:if>

</div>










