<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<script>

	$(document).ready(function(){
		teamCall();
		googleMapCall();
	});
 
	function launchGoogleMap(){
		window.open("googleMap.mr", "subwinpop", "left=300px, top=300px, width=600px, height=500px");
	} 

	function teamCall(){
		$.ajax({
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
				var leader = data[0].leader
				
				
				$("#tm").empty();
				
				var html = "";
				<%-- <img src="<%= request.getContextPath() %>/resources/files/20171208183923121001009307995.jpg" style="width:200px; heigth:200px;"> --%>
				html += "<img src='<%= request.getContextPath() %>/resources/files/"+img+"' height='150px;' width='150px;'><br/>";
				html += "팀 이름 : " + name + "<br/>";
				html += "설립자 : " + leader + "<br/>";
				html += "전화번호 : " + tel1 + "-" + tel2 + "-" + tel3 + "<br/>";
				html += "우편번호 : " + post1 + "-" + post2 + "<br/>";
				html += "주소 : " + addr1 + " " + addr2 + "<br/>";
				html += "설립일 : " + regdate + "<br/>";
				
				$("#tm").html(html);
			}, error: function(request, status, error){
				alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
			}
		});
	}
	
	function googleMapCall(){
		
	}
</script>


<br/><br/>
<div align="center" style="float:left; width:400px; height:150px; margin-left:400px;"><a class="btn btn-primary" onclick="launchGoogleMap()">크게 보기</a><br/></div>
<div align="left" style="display:inline-block; width:500px; height:150px; margin-left:50px;" id="tm"></div>
<br/><br/>
<br/><br/>

<div class="modal-body" id="launchMapBody" style="width:50%; height:10%; border:1px solid blue;">
	<!-- <div id="googleMap"	style="width: 40%; height: 70%; margin: auto; margin:20% 10% 20% 20% ; "></div> -->
	
</div>


<div style="float:left; border:1px solid red; width:50px; height:50px;">
	<div style="border: 3px solid blue;"> 
		<iframe src="<%=request.getContextPath()%>/googleMapbasic.mr" style="border:1px solid pink;"></iframe>
	</div>
	
	<div style="border: 3px solid green;">
		<div style="float:left; width:500px; height:400px; margin-left:400px; border:1px solid red"><a class="btn btn-primary" onclick="launchGoogleMap()">구글 맵으로 보기</a></div>
	</div>
	
</div>
	
<div style="float:left; border:1px solid pink; width:50px; height:50px;"> 
	<div align="left" style="float:left; width:50%; height:100%; margin-left:50px; border:1px solid black;" id="tm"></div>
</div>
