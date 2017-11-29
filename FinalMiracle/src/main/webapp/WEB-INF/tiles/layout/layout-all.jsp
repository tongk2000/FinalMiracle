<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"  %>   
   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Final Project</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resources/BootStrapStudy/css/bootstrap.css">
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/jquery-2.0.0.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/BootStrapStudy/js/bootstrap.js"></script>

<style type="text/css">
	.container{border:1px solid red; width:90%; min-height:1000px; padding:0px;}
	.header{border:1px solid black; width:100%; min-height:50px;}
	.sideInfo{border:1px solid blue; width:10%; min-height:850px; float:left;}
	.content{border:1px solid green; width:90%; min-height:850px; float:right;}
	.footer{border:1px solid black; width:100%; min-height:100px; clear:both;}
</style>

</head>
<body>
	<div class="container">
		<div class="header">
		      <tiles:insertAttribute name="header" />
		</div>
		
		<div class="sideInfo">
		      <tiles:insertAttribute name="sideInfo" />
		</div>
		
		<div class="content">
		      <tiles:insertAttribute name="content" />
		</div>
		
		<div class="footer">
		      <tiles:insertAttribute name="footer" />
		</div>
	</div>
</body>

</html>
