<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<script>

	$(document).ready(function(){
		teamCall();
		googleMapCall();
	});

	function launchGoogleMap(){
		window.open("googleMap.mr", "subwinpop", "left=300px, top=300px, width=600px, height=500px");
	}
<<<<<<< HEAD
</script>

<div style=""></div>

<a class="btn btn-primary" onclick="launchGoogleMap()">Launch googleMap</a>
=======
	
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
				<%-- <img src="<%= request.getContextPath() %>/resources/files/20171208183923121001009307995.jpg" style="width:200px; heigth:200px;"> --%>
				html += "<img src='<%= request.getContextPath() %>/resources/files/"+img+"' height='150px;' width='150px;'><br/>";
				html += "이름 : " + name + "<br/>";
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
<div align="center" style="float:left; width:400px; height:150px; margin-left:400px;"><a class="btn btn-primary" onclick="launchGoogleMap()">구글 맵으로 보기</a></div>
<div align="left" style="display:inline-block; width:500px; height:150px; margin-left:50px;" id="tm"></div>
<br/><br/>
<br/><br/>
>>>>>>> branch 'master' of https://github.com/tongk2000/FinalMiracle.git
