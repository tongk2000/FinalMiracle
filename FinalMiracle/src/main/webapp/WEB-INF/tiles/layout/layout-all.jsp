<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"  %>   
   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Final Project</title>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resources/BootStrapStudy/css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/jqueryuicss/jquery-ui.css" />
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css" />

<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/jquery-2.0.0.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/BootStrapStudy/js/bootstrap.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/jqueryuijs/jquery-ui.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/jquery.form.min.js"></script> <!-- 파일까지 업로드 가능한 jquery form 플러그인 -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>

<style type="text/css">
	html, body{height:100%;}
	.miracleLayout {
		border:none !important;
		padding:0px !important;
		margin:0px !important;
		text-align:left !important;
	}
	#layoutTable {
		width:100% !important;
		height:100% !important;
	}
	#firstMiracleLine {
		width:100% !important;
		height:50px !important;"
	}
	#secondMiracleLine {
		width:100% !important;
		height:100% !important;
		vertical-align:top !important;
	}
	#toggleSidebar {
		height:50px !important;
		width:50px !important;
		background-color:#4882ab !important;
	}
	#header {
		height:50px !important;
		background-color:#1f5c87 !important;
	}
	#sideInfo {
		width:50px !important;
		background-color:#1f5c87 !important;
	}
	#content {
		
	}
	.iconPng {
		width:35px !important;
		heigth:35px !important;
		margin-left:0px !important;
	}
	.sideIconPng {
		margin-top:10px !important;
		margin-bottom:10px !important;
	}
	.toggleInconPng {
		margin-top:7.5px !important;
		margin-left:7.5px !important;
	}
</style>

</head>
<body id="body">
	<table class="miracleLayout" id="layoutTable">
		<tr class="miracleLayout" id="firstMiracleLine">
			<td id="toggleSidebar" class="miracleLayout">
				<a title="메뉴상세">
					<img src="<%= request.getContextPath() %>/resources/images/icon/00.png" class="iconPng toggleInconPng" />
					<span class="toggleText"></span>
				</a>
			</td>
			<td id="header" class="miracleLayout">
				<tiles:insertAttribute name="header"/>
			</td>
		</tr>
		<tr class="miracleLayout" id="secondMiracleLine">
			<td id="sideInfo" class="miracleLayout">
				<tiles:insertAttribute name="sideInfo"/>
			</td>
			<td id="content" class="miracleLayout">
				<tiles:insertAttribute name="content"/>
			</td>
		</tr>
	</table>
</body>
</html>
