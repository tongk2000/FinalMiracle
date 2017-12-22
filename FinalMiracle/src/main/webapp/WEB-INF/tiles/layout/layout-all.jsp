<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"  %>
<%@ taglib prefix="c" uri="http://tiles.apache.org/tags-tiles"  %>   
   
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

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<!-- <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script> -->

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
	.toggleSidebarOff {
		height:50px !important;
		width:50px !important;
		background-color:#4882ab;
	}
	.toggleSidebarOn {
		height:50px !important;
		width:135px !important;
		background-color:#4882ab;
	}
	#header {
		height:50px !important;
		background-color:#1f5c87 !important;
	}
	#sideInfo {
		background-color:#1f5c87 !important;
	}
	#content {
		
	}
	
	.iconPng {	
		margin-left:7.5px !important;
	}
	.sideIconPng {
		width:30px !important;
		heigth:30px !important;
		margin-top:10px !important;
		margin-bottom:10px !important;
	}
	.headerIconPng {
		width:30px !important;
		heigth:30px !important;
		margin-top:7.5px !important;
		margin-left:12.5px !important;
	}
	.iconTag {
		cursor:pointer !important;
	}
	.headerDiv {
		margin:0px !important;
		width:60px !important;
		float:left !important;
		height:50px !important;
		display:inline-block !important;
	}
	
	.selectMenuColor {
		background-color:#154465 !important;
	}
	.selectToggleMenuColor {
		background-color:#205b86 !important;
	}
	.toggleText {
		margin-left:8px;
		display:none;
		color:white;
		font-family:verdana;
	}
</style>

<script type="text/javascript">
	$(document).ready(function(){
		// 선택한 메뉴에 css 입히기 시작
		var selectIcon = "${sessionScope.sideKeepMap.selectIcon}";
		var toggleIcon = "${sessionScope.sideKeepMap.toggleIcon}";
		if(selectIcon == "") { // 선택한 메뉴가 없다면(첫화면이라면)
			selectIcon = "doIcon";
		}
		$("#"+selectIcon).css({"background-color":"#154465 !important"});
		
		if(toggleIcon == "true") { // 상세메뉴를 켠 상태였다면
			$("span.toggleText").show();
  			$("#toggleSidebar").removeClass("toggleSidebarOff");
	  		$("#toggleSidebar").addClass("toggleSidebarOn");
		}
		// 선택한 메뉴에 css 입히기 끝 ----------------------------------------------------------------------------------------
		
		// 선택한 메뉴에 css 입히기 위해 사이드바 메뉴 클릭시 메뉴값을 ajax로 보내서 세션에 저장함  
		$(".sideBarLi").click(function(){
	    	var frm = {
	    		"selectIcon":$(this).attr("id"),
	    		"toggleIcon":$("span.toggleText").is(":visible")
	    	};
	    	$.ajax({
	    		url:"setSelectIconToSession.mr",
	    		data:frm
	    	});
	    }); // end of $(".sideBarLi").click(function() ----------------------------------------------------------------------------
		
	 	// 메뉴 아이콘 hover
	    $(".iconTag").hover(function(){
	    	$(this).addClass("selectMenuColor");
	    }, function(){
	    	$(this).removeClass("selectMenuColor");
	    }); // end of $(".iconTag").hover(function() -----------------------------------------------------------------------------------
	    
	    // 토글 메뉴 아이콘 hover
	    $("#toggleSidebar").hover(function(){
	    	$(this).addClass("selectToggleMenuColor");
	    }, function(){
	    	$(this).removeClass("selectToggleMenuColor");
	    }); // end of $("#toggleSidebar").hover(function() ---------------------------------------------------------------------------------
	  	
	    // 토글 메뉴 클릭시 아이콘 <-> 상세메뉴 토글하기  
	  	$("#toggleSidebar").click(function(){
	  		$("span.toggleText").toggle();
	  		var bool = $("span.toggleText").is(":visible");
	  		if(bool) {
	  			$("#toggleSidebar").removeClass("toggleSidebarOff");
		  		$("#toggleSidebar").addClass("toggleSidebarOn");	
	  		} else {
	  			$("#toggleSidebar").removeClass("toggleSidebarOn");
		  		$("#toggleSidebar").addClass("toggleSidebarOff");
	  		}
	  	}); // end of $("#toggleSidebar").click(function() --------------------------------------------------------------------------------
	});
</script>

</head>
<body id="body">
	<table id="layoutTable" class="miracleLayout">
		<tr id="firstMiracleLine" class="miracleLayout">
			<td id="toggleSidebar" class="miracleLayout toggleSidebarOff" title="메뉴상세" style="cursor:pointer;">
				<img src="<%= request.getContextPath() %>/resources/images/icon/15.png" class="headerIconPng" style="margin-top:0px !important; margin-left:7.5px !important;" />
				<span class="toggleText">메뉴상세</span>
			</td>
			<td id="header" class="miracleLayout">
				<tiles:insertAttribute name="header"/>
			</td>
		</tr>
		<tr id="secondMiracleLine" class="miracleLayout">
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
