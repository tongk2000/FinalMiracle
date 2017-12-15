<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>채팅방 만들기</title>

<style type="text/css">


</style>

<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/jquery-2.0.0.js"></script>

<script type="text/javascript">
	$(document).ready(function() {
		
		
		
		$("#teamList").val("");
		
		$("#teamList").change(function() {
			//alert($(this).val());
			var idx = $(this).val();
			var form_data = {tidx : idx}
			$.ajax({
				url: "getTeamwonNotMe.mr",
				data: form_data,
				type: "get",		// 위의 url주소로 보내어질 요청대이터이다
				dataType: "html",	// ajax 요청에의해 url주소(chattingRoomAjax.mr)로 리턴받는 데이터 타입이다
				 					// 종류가 xml, json, html, script, text
				success: function(data) { // success => url주소(chattingRoomAjax.mr)로 부터 받은 응답이 요청에 성공했다는 것을 말한다
											// function(data) {}를 콜백함수라고 부르는데 성공한 다음에 실행할것들을 여기에 서술한다
											// 그리고 data는 url주소(chattingRoomAjax.mr)로부터 리턴받은 데이터이다
					$("#MemberList").empty(); // 해당요소 선택자 내용을 모두 비워서 새로운 데이터를 채울 준비를 한다
					$("#memberinfo").empty();
					$("#MemberList").html(data);
				},
				error: function(request, status, error) {
					alert("code: " + request.status + "\n"+"message: " + request.responseText + "\n" + "error: " + error);     
				}
			});
			
		});
		
		$("#AllMember").click(function() {
			$("#teamList").val("");
			$.ajax({
				url: "getAllNotMe.mr",
			//	data: form_data,
				type: "get",		// 위의 url주소로 보내어질 요청대이터이다
				dataType: "html",	// ajax 요청에의해 url주소(chattingRoomAjax.mr)로 리턴받는 데이터 타입이다
				 					// 종류가 xml, json, html, script, text
				success: function(data) { // success => url주소(chattingRoomAjax.mr)로 부터 받은 응답이 요청에 성공했다는 것을 말한다
											// function(data) {}를 콜백함수라고 부르는데 성공한 다음에 실행할것들을 여기에 서술한다
											// 그리고 data는 url주소(chattingRoomAjax.mr)로부터 리턴받은 데이터이다
					$("#MemberList").empty(); // 해당요소 선택자 내용을 모두 비워서 새로운 데이터를 채울 준비를 한다
					$("#memberinfo").empty();
					$("#MemberList").html(data);
				},
				error: function(request, status, error) {
					alert("code: " + request.status + "\n"+"message: " + request.responseText + "\n" + "error: " + error);     
				}
			});
		});
		
		$("#nameORid").keydown(function (key) {
            if (key.keyCode == 13) {
               $("#serchMem").click();
            }
         });
		$("#serchMem").click(function() {
			$("#teamList").val("");
			
			var what = $("#nameOrId").val();
			var subject = $("#nameORid").val();
			
			var form_data = {subject : subject
							,what : what};
			$.ajax({
				url: "getFindNotMe.mr",
				data: form_data,
				type: "get",		// 위의 url주소로 보내어질 요청대이터이다
				dataType: "html",	// ajax 요청에의해 url주소(chattingRoomAjax.mr)로 리턴받는 데이터 타입이다
				 					// 종류가 xml, json, html, script, text
				success: function(data) { // success => url주소(chattingRoomAjax.mr)로 부터 받은 응답이 요청에 성공했다는 것을 말한다
											// function(data) {}를 콜백함수라고 부르는데 성공한 다음에 실행할것들을 여기에 서술한다
											// 그리고 data는 url주소(chattingRoomAjax.mr)로부터 리턴받은 데이터이다
					$("#MemberList").empty(); // 해당요소 선택자 내용을 모두 비워서 새로운 데이터를 채울 준비를 한다
				//	$("#memberinfo").empty();
					$("#MemberList").html(data);
				},
				error: function(request, status, error) {
					alert("code: " + request.status + "\n"+"message: " + request.responseText + "\n" + "error: " + error);     
				}
			});
			
			
		});
		
		
	});

	
</script>

</head>
<body>
	<div style="font-size: 20px;">
		<div style="display: inline; margin: 20px;"><span id="AllMember">전체인원 보기</span></div>
		<div style="display: inline; margin: 20px;">팀별 보기 : 
		  <select id="teamList">
		    <c:forEach var="team" items="${teamList}" varStatus="status">
				<option value="${team.tidx}">${team.name}</option>
			</c:forEach>
		  </select>
		</div>
		<div style="display: inline-block; margin: 20px;">
		<select id="nameOrId">
			<option value="name">이름</option>
			<option value="userid">아이디</option>
		</select>
		<input id="nameORid" type="text"/>&nbsp;<span id="serchMem">찾기</span>
		</div>
		<div id="MemberList" style="border: 1px solid teal; height : 400px; overflow: auto;"></div>
		<div style="margin-left: 30px;"><input type="text" id="roomname" placeholder="채팅방 이름" />&nbsp;<span>방만들기</span></div>
	</div>
	
</body>
</html>