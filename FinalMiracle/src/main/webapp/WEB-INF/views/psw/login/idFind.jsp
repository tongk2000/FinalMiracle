<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MiracleCoder_LogIn</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resources/BootStrapStudy/css/bootstrap.css">
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/jquery-2.0.0.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/BootStrapStudy/js/bootstrap.js"></script>

<style type="text/css">
	a {text-decoration: none;}

	.mydiv {display: inline-block; 
	        position: relative; 
	        top: 30px; 
	        line-height: 150%; 
	       }
	
	.mydisplay {display: block;}
	       	
	.myfont {font-size: 14pt; color: white; font-weight: bold;}
	
</style>

<style type="text/css">
	
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
		
		var method = "${method}";
	
	    if (method == "GET") {
	       $("#div_finalResult").hide();
	       $("#name").val("");
		   $("#mobile").val("");
	    }
		
		$("#btnFind").click(function(){
			var frm = document.idFindFrm;
			frm.method = "post";
			frm.action = "<%= request.getContextPath() %>/member_idFind.mr";
			frm.submit();
		});
		
		if (method == "POST") {
		    $("#name").val("${name}");
		    $("#mobile").val("${mobile}");
		    $("#div_finalResult").show();
		}
		
	});

</script>

</head>


<body>
		
	<div class="content">
	
		<form name="idFindFrm">
		   <div id="div_name" align="center">
		   	  <span style="color: blue; font-size: 12pt;" >성명</span><br/>
		   	  <input type="text" id="name" name="name" size="15" placeholder="성명" required />
		   </div>
		   
		   <div id="div_mobile" align="center">
		   	  <span style="color: blue; font-size: 12pt;" >휴대전화</span><br/>
		   	  <input type="text" id="mobile" name="mobile" size="15" placeholder="-없이 입력하세요" required />
		   </div>
		   
		   <div id="div_finalResult" align="center">
		   	  ID : <span style="color: red; font-size: 16pt; font-weight: bold;">${userid}</span>  
		   </div>
		   
		   <div id="div_btnFind" align="center">
		   	  <button type="button" class="btn btn-success" id="btnFind">찾기</button>	
		   </div>
		   
		</form>
	
	</div>


</body>






    
    
    
    
    
    
    
    