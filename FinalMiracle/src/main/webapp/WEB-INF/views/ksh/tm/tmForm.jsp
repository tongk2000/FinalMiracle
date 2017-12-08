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


<body>
	<div class="content">
		<div style="width: 60%; margin-top: 10%; margin-left: 20%; height: 500px; border-radius: 10px; background-color: #4F84C4;">
			<br/>
			<h2 style="text-align: center;">
				<span style="color: #FAE03C;">Miracle World</span>
			</h2>
			<p class="bg-primary">&nbsp;</p>

			<form name="teamFrm" style="margin-left: 20%;">
				<div class="mydiv" style="margin-left: 15%;" align="center">
					<span class="mydisplay myfont">팀장인 팀</span>
					<span class="mydisplay myfont" style="margin-top: 30px;">팀원인 팀</span>
				</div>
				<div class="mydiv" style="margin-left: 5%;">
					<select class="mydisplay form-control" name="team_idx1" id="team_idx1" style="size: 200px;">
						<option value="">선택</option>
						<c:forEach var="teamvo" items="${teamlist1}" varStatus="status">
							<option value="${teamvo.IDX}">${teamvo.NAME}</option>
							<input type="hidden" id="teamname" name="teamname" value="${teamvo.NAME}" />
							<input type="hidden" id="" name="" value="${teamvo.NAME}" />
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
				<br/><br/>
				<div class="mydiv" style="margin-left: 20%;">
					&nbsp;&nbsp;&nbsp;
					<button class="btn btn-success" style="width: 100px; font-size: 14pt;" type="button" id="teamCreate" onclick="javascript:location.href='<%= request.getContextPath() %>/tmCreate.mr'">팀 생성</button>
					<button class="btn btn-danger" style="width: 100px; font-size: 14pt;" type="button" id="logout" onclick="javascript:location.href='<%= request.getContextPath() %>/member_logout.mr'">로그아웃</button>
				</div>
			</form>
		</div>
	</div>

</body>