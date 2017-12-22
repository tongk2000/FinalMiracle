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
		
		$("#team_idx1").change(function(){
			var frm = document.teamFrm;
			
			frm.action = "<%= request.getContextPath() %>/tmSession.mr";
			frm.method = "get";
			frm.submit();
			
			<%-- location.href="<%= request.getContextPath() %>/doList.mr"; --%>
		});
		
		$("#team_idx2").change(function(){
			var frm = document.teamFrm;
			
			frm.action = "<%= request.getContextPath() %>/tmSession.mr";
			frm.method = "get";
			frm.submit();
			
			<%-- location.href="<%= request.getContextPath() %>/doList.mr"; --%>
		});
	 
    });
	
</script>


</head>


<body background="<%= request.getContextPath() %>/resources/images/loginbg.png">
	<div class="content" style="width: 100%; vertical-align: middle; margin-top: 15%;" align="center">
		<div style="width: 600px; height: 400px; border-radius: 10px; background-color: #4F84C4; margin: 100px;" align="center">
			<div style="padding-top: 5px; padding-bottom: 5px;">
				<h2 style="text-align: center;">
					<span style="color: #FAE03C; font-family: verdana;"">Miracle World</span>
				</h2>
				<p class="bg-primary">&nbsp;</p>
			</div>
			
			<div>
				<form name="teamFrm">
					<div class="mydiv" align="center">
						<span class="mydisplay myfont">팀장인 팀</span>
						<span class="mydisplay myfont" style="margin-top: 30px;">팀원인 팀</span>
					</div>
					<div class="mydiv" style="margin-left: 3%;">
						<select class="mydisplay form-control" name="team_idx1" id="team_idx1" style="size: 200px;">
							<option value="">선택</option>
							<c:forEach var="teamvo" items="${teamlist1}" varStatus="status">
								<option value="${teamvo.IDX}">${teamvo.NAME}</option>
							</c:forEach>
						</select>
						<br/>
						<select class="mydisplay form-control" name="team_idx2" id="team_idx2" style="size: 200px;">
							<option value="">선택</option>
							<c:forEach var="teamvo" items="${teamlist2}" varStatus="status">
								<option value="${teamvo.IDX}">${teamvo.NAME}</option>
							</c:forEach>
						</select>
					</div>
					<br/><br/><br/><br/>
					<div class="mydiv">
						&nbsp;&nbsp;&nbsp;
						<button class="btn btn-success" style="width: 100px; font-size: 14pt;" type="button" id="teamCreate" onclick="javascript:location.href='<%= request.getContextPath() %>/tmCreate.mr'">팀 생성</button>
						<button class="btn btn-danger" style="width: 100px; font-size: 14pt;" type="button" id="logout" onclick="javascript:location.href='<%= request.getContextPath() %>/member_logout.mr'">로그아웃</button>
					</div>
				</form>
			</div>
		</div>
	</div>

</body>