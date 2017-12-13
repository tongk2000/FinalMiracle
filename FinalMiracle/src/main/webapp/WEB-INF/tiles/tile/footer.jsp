<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<script>
	$(document).ready(function(){
		teamCall();
	});
 
	function launchGoogleMap(){
		window.open("googleMap.mr", "subwinpop", "left=300px, top=300px, width=600px, height=500px");
	} 
	function teamCall(){
		return $.ajax({
			url: "tmFooter.mr",
			type: "GET",
			dataType: "JSON",
			success: function(data){
				var name = data[0].name;
				var tel1 = data[0].tel1;
				var tel2 = data[0].tel2;
				var tel3 = data[0].tel3;
				var post1 = data[0].post1;
				var post2 = data[0].post2;
				var addr1 = data[0].addr1;
				var addr2 = data[0].addr2;
				var regdate = data[0].regdate;
				var img = data[0].img
				
				
				$("#tm").empty();
				
				var html = "";
				<%-- html <img src="<%= request.getContextPath() %>/resources/files/20171208183923121001009307995.jpg" style="width:200px; heigth:200px;" /> --%>
				html += "<img src='<%= request.getContextPath() %>/resources/files/"+img+"' height='150px;' width='150px;'><br/>";
				html += "이름 : " + name + "<br/>";
				html += "전화번호 : " + tel1 + "-" + tel2 + "-" + tel3 + "<br/>";
				html += "우편번호 : " + post1 + "-" + post2 + "<br/>";
				html += "주소 : <a onClick='launchGoogleMap();'>" + addr1 + " " + addr2 + "</a><br/>";
				html += "설립일 : " + regdate + "<br/>";
				
				$("#tm").html(html);
			}, error: function(request, status, error){
				alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
			}
		});
	}

	
</script>
<style>
	.ifram {overflow-Y:hidden;}
</style>

<div style="width:100%; height:100px; border:4px dotted red; ">
	<div style="border:4px dotted skyblue; width:50%; float: left;">
		<!-- 회사정보 -->
		<div class="footer" style="border:4px dotted blue; width:100%; float: left;"> 
			<div class="footer" id="tm" style="border:4px dotted green; width:100%;"></div>
		</div>
	</div>
	<div style="border:4px dotted yellow; width:50%; float: right;">
	<!-- 구글맵 -->
		<div class="footer googleMap" style="border: 2px solid blue; width: 100%; height:265px;"> 
			<iframe class="ifram" src="<%=request.getContextPath()%>/googleMapbasic.mr" style="border:1px solid pink; width:100%; heigth:100%;"></iframe>
		</div>
	</div>	
</div>

<!-- <div class="modal-body" id="launchMapBody" style="border:4px solid red"> 
	<div id="googleMap"	style="width: 40%; height: 70%; margin: auto; margin:20% 10% 20% 20% ; "></div>
</div> -->

<%-- 
<div style="float:left; width:50%;">
	<!-- 구글맵 -->
	<div class="footer googleMap" style="border: 2px solid blue; width: 100%;"> 
		<iframe src="<%=request.getContextPath()%>/googleMapbasic.mr" style="border:1px solid pink; height:300px;"></iframe>
	</div>
	<!-- 버튼 -->
	<div class="footer bt container" style="border: 2px solid green; background-color: lightgray; width: 100%; height:200px;">
		<div style="width:200px; height:200px; margin-left:100px; border:1px solid red"><a class="btn btn-primary" onclick="launchGoogleMap()">구글 맵으로 보기</a></div>
	</div>
</div> --%>
<!-- scrolling="no" -->
