<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<script type="text/javascript">
	$(document).ready(function(){
		teamCall();
	});
 
	function launchGoogleMap(){
		window.open("googleMap.mr", "subwinpop", "left=300px, top=300px, width=600px, height=600px");
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
<<<<<<< HEAD
				html <img src="<%= request.getContextPath() %>/resources/files/20171208183923121001009307995.jpg" style="width:200px; heigth:200px;" />
=======
				<%-- html <img src="<%= request.getContextPath() %>/resources/files/20171208183923121001009307995.jpg" style="width:200px; heigth:200px;" /> --%>
<%-- >>>>>>> branch 'master' of https://github.com/tongk2000/FinalMiracle.git
>>>>>>> branch 'master' of https://github.com/tongk2000/FinalMiracle.git
				html += "<img src='<%= request.getContextPath() %>/resources/files/"+img+"' height='150px;' width='150px;'><br/>";
				html += "팀 이름 : " + name + "<br/>";
				html += "설립자 : " + leader + "<br/>";
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
</style>

<div style="width:100%; height:500px; border:4px dotted red; "> <!-- 전체 푸터 -->
	<div style="border:4px dotted skyblue; width:50%; float: left;">
		<!-- 회사정보 -->
		<div class="footer" style="border:4px dotted blue; width:100%; float: left;"> 
			<div class="footer" id="tm" style="border:4px dotted green; width:100%;"></div>
		</div>
	</div>
	<div style="border:4px dotted yellow; width:50%; height: 500px; float: right;">
		<div class="footer googleMap" style="border: 2px solid blue; width: 100%; height:500px;"> 
			<iframe class="ifram" src="<%=request.getContextPath()%>/googleMapbasic.mr" style="border:1px solid pink; width:100%; heigth:500px;" ></iframe>
		</div>
	</div>	
<<<<<<< HEAD
</div>  --%>
=======
</div> --%> 

<!-- <br/><br/>
<div align="center" style="float:left; width:400px; height:150px; margin-left:400px;"><a class="btn btn-primary" onclick="launchGoogleMap()">크게 보기</a><br/></div>
<div align="left" style="display:inline-block; width:500px; height:150px; margin-left:50px;" id="tm"></div>
<br/><br/>
<br/><br/>

<div class="modal-body" id="launchMapBody" style="width:50%; height:10%; border:1px solid blue;">
	<div id="googleMap"	style="width: 40%; height: 70%; margin: auto; margin:20% 10% 20% 20% ; "></div>
	
>>>>>>> branch 'master' of https://github.com/tongk2000/FinalMiracle.git
</div> -->

<!-- <div class="modal-body" id="launchMapBody" style="border:4px solid red"> 
	<div id="googleMap"	style="width: 40%; height: 70%; margin: auto; margin:20% 10% 20% 20% ; "></div>
</div> -->

<%-- 
<div style="float:left; width:50%;">
	<!-- 구글맵 -->
	<div class="footer googleMap" style="border: 2px solid blue; width: 100%;"> 
		<iframe src="<%=request.getContextPath()%>/googleMapbasic.mr" style="border:1px solid pink; height:300px;"></iframe>
=======
>>>>>>> branch 'master' of https://github.com/tongk2000/FinalMiracle.git
	</div>
</div>--%>
>>>>>>> branch 'master' of https://github.com/tongk2000/FinalMiracle.git
