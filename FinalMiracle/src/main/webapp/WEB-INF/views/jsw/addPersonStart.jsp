<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
	$(document).ready(function() {
		var cridx = ${cridx};
		
		$("#teamList").val("");
		
		$("#teamList").change(function() {
			//alert($(this).val());
			var idx = $(this).val();
			var form_data = {tidx : idx
							,cridx : cridx}
			$.ajax({
				url: "getTeamwonNotChatMember.mr",
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
			var cridx_data = {cridx : cridx}
			$.ajax({
				url: "getAllNotChatMember.mr",
				data: cridx_data,
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
							,what : what
							,cridx : cridx};
			$.ajax({
				url: "getFindNotChatMember.mr",
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
		$("#inviteMember1").click(function() {
		var inv = $('.inv').length;
			if(inv <= 0){
				alert("초대할 인원을 선택해야합니다");
			}
			else {
		//		var cridx = ${cridx};
		//		alert(cridx);
				var form_data = {cridx : cridx};
				$.ajax({
					url: "addPersonEndchat.mr",
					data: form_data,
					type: "get",		// 위의 url주소로 보내어질 요청대이터이다
					dataType: "html",	// ajax 요청에의해 url주소(chattingRoomAjax.mr)로 리턴받는 데이터 타입이다
					 					// 종류가 xml, json, html, script, text
					success: function(data) { // success => url주소(chattingRoomAjax.mr)로 부터 받은 응답이 요청에 성공했다는 것을 말한다
												// function(data) {}를 콜백함수라고 부르는데 성공한 다음에 실행할것들을 여기에 서술한다
												// 그리고 data는 url주소(chattingRoomAjax.mr)로부터 리턴받은 데이터이다

						$("#newChattingRoom").remove();
						$("#addPerson").remove();
						$("#roominfo").show();
						$("#chatMessage").show();
						$("#message").show();
						$("#sendMessage").show();
						$("#chatMessage").html(data);
					
					},
					error: function(request, status, error) {
						alert("code: " + request.status + "\n"+"message: " + request.responseText + "\n" + "error: " + error);     
					}
				});

				
				$('.inv').each(function(i) {
					var id = document.getElementsByClassName('twon')[i].id;
					var memberidx = $('#'+id).val();
					
					
					var midx_data = {memberidx : memberidx
									,cridx : cridx};
					$.ajax({
						url: "addPersonEndmember.mr",
						data: midx_data,
						type: "get",		// 위의 url주소로 보내어질 요청대이터이다
						dataType: "html",	// ajax 요청에의해 url주소(chattingRoomAjax.mr)로 리턴받는 데이터 타입이다
						 					// 종류가 xml, json, html, script, text
						success: function(data) { // success => url주소(chattingRoomAjax.mr)로 부터 받은 응답이 요청에 성공했다는 것을 말한다
													// function(data) {}를 콜백함수라고 부르는데 성공한 다음에 실행할것들을 여기에 서술한다
													// 그리고 data는 url주소(chattingRoomAjax.mr)로부터 리턴받은 데이터이다
						//	$("#MemberList").empty(); // 해당요소 선택자 내용을 모두 비워서 새로운 데이터를 채울 준비를 한다
							$("#memberinfo").empty();
							$("#memberinfo").html(data);
						},
						error: function(request, status, error) {
							alert("code: " + request.status + "\n"+"message: " + request.responseText + "\n" + "error: " + error);     
						}
					});
					
					
				});// end of each			
				
				
				$("#message").show();
				$("#sendMessage").show();
				alert("초대하였습니다");
				getRoomList();
		}
		


	
		});
		
		
	});
</script>

<div id="addPerson" style="font-size: 20px; height:100%;">
	<div>
		<div style="float:left; margin-left:23%;">
			<span id="AllMember" class="btn btn-lg">
				<span class="glyphicon glyphicon-user"></span> 
				전체인원 보기
			</span>
		</div>
		<div style="float:left; margin-top:8px;">팀별 보기 : 
			<select id="teamList" style="height:30px;">
				<c:forEach var="team" items="${teamList}" varStatus="status">
					<option value="${team.tidx}">${team.name}</option>
				</c:forEach>
			</select>
		</div>
	</div>
	<br/>
	<div style="margin:20px; clear:both; vertical-align: bottom;" align="center">
		<select id="nameOrId" style="height: 33px;">
			<option value="name">이름</option>
			<option value="userid">아이디</option>
		</select>
		<!-- <a class="btn btn-sm btn-info" onclick="searchMonth()"><span class="glyphicon glyphicon-search"></span> 검색</a> -->
		<input id="nameORid" type="text"/>&nbsp;
		<span id="serchMem" class="btn btn-info">
			<span class="glyphicon glyphicon-search"></span>
			찾기
		</span>
	</div>
	<div id="MemberList" style="border: 0px solid teal; min-height:78%; overflow: auto;"></div>
	<div style="text-align:center;">
		<span id="inviteMember1" class="btn btn-lg" style="background-color: yellow; margin-right: 20px;">초대하기</span>
		<span class="btn btn-lg btn-danger" onclick="goChatRoom(${cridx})">취소하기</span>
	</div>
</div>
<form id="newRoomFrm">
	<input type="hidden" name="invmemidx" />
</form>





















