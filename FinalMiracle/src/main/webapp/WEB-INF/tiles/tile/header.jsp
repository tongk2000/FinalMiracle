<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.net.InetAddress"%>

<%-- ===== tiles 중 header 페이지 만들기  ===== --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<%
	// === 서버 IP 주소 알아오기 === //
	InetAddress inet = InetAddress.getLocalHost();
	String serverIP = inet.getHostAddress();
	int portnumber = request.getServerPort();

	String serverName = "http://" + serverIP + ":" + portnumber;
%>

<style type="text/css">
	
	.modal.modal-center {
	  text-align: center;
	}
	
	@media screen and (min-width: 768px) { 
	  .modal.modal-center:before {
	    display: inline-block;
	    vertical-align: middle;
	    content: " ";
	    height: 100%;
	  }
	}
	
	.modal-dialog.modal-center {
	  display: inline-block;
	  text-align: left;
	  vertical-align: middle; 
	}

</style>

<script type="text/javascript">
	
	$(document).ready(function(){
		
		
	});

	function showMyInfo() {
		$.ajax({
			url: "member_edit.mr",
			type: "GET",
			dataType: "HTML", // ajax 요청에 의해 url 요청페이지로 부터 리턴받는 데이터타입. xml, json, html, text 가 있음.
			success: function(data) {	
				$("#modalBody").html(data);
				$("#memberEditModal").modal();
			}, // end of success: function()----------
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		}); // end of $.ajax()------------------------
	}
</script>

<div style="/* border: 3px solid pink; */ width: 100%; height: 50px; background-color: #ffffff;">
	<!-- 로고(클릭시 메인페이지-일정관리 이동) -->
	<div style="/* border: 3px solid green; */ float: left; width: 33%">
		<a href="<%= request.getContextPath() %>/doList.mr" title="메인 페이지"><img src="<%= request.getContextPath() %>/resources/images/icon/00.png" style="width:50px; heigth:50px;" /></a>
	</div>

	<!-- 통합검색메뉴 -->
	<div style="/* border: 1px solid blue; */ float: left; width: 30%; height: 50px;" align="right">
		<input type="text" class="form-control input-md" style="margin-top: 7px; width: 80%;" placeholder="통합 검색" />
	</div>
	
	<div style="/* border: 1px solid blue; */ float: left; width: 3%; height: 50px;" align="center">
		<a href="<%= request.getContextPath() %>/doList.mr" title="검색"><img src="<%= request.getContextPath() %>/resources/images/icon/14.png" style="width: 40px; height: 35px; margin-top: 7px;" /></a>
	</div>

	<!-- ===== 로그인 성공한 사용자 정보 출력 ===== -->
	<c:if test="${sessionScope.loginUser != null}">
		<div style="/* border: 3px solid yellow; */ float: left; width: 33%; height: 50px;" align="right">
			<!-- <div style="/* border: 1px solid maroon; */"><span style="color: black;">사용자 정보</span></div>
			<div class="user img" style="float: left; width: 30%; height: 50px; /* border: 2px solid red; */">
				<img src="<%= request.getContextPath() %>/resources/images/${sessionScope.loginUser.img}" style="height: 50px; width: 50px;">&nbsp;&nbsp;
			</div>
			<div class="user id" style="float: right; width: 55%; /* border: 1px solid blue; */">
				<span style="color: black;">아이디 : </span><span style="color: navy; font-weight: bold;">${sessionScope.loginUser.userid}</span><br/>
				<span style="color: black;">회원명 : </span><span style="color: navy; font-weight: bold;">${sessionScope.loginUser.name}</span><br/>
				<a href="<%= request.getContextPath() %>/tmForm.mr" title="팀 선택"><img src="<%= request.getContextPath() %>/resources/images/icon/12.png" style="width:50px; heigth:50px;" /></a>
			</div>
			<br />
			<div class="user menu" style="float: right; /* border: 1px solid cyan; */">
				<a href="<%=request.getContextPath()%>/member_edit.mr">[내정보수정]</a> &nbsp;&nbsp; 
				<a href="<%=request.getContextPath()%>/member_logout.mr">[로그아웃]</a>
			</div> -->
			
			<a href="<%= request.getContextPath() %>/tmForm.mr" title="팀 선택"><img src="<%= request.getContextPath() %>/resources/images/icon/12.png" style="width:50px; heigth:50px;" /></a>
			<a href="<%= request.getContextPath() %>/member_logout.mr" title="로그아웃"><img src="<%= request.getContextPath() %>/resources/images/icon/13.png" style="width:30px; heigth:30px;" /></a>
			<a href="javascript:showMyInfo();" title="${sessionScope.loginUser.name}(${sessionScope.loginUser.userid})"><img src="<%= request.getContextPath() %>/resources/images/${sessionScope.loginUser.img}" style="height: 50px; width: 50px;"></a>
		</div>
	</c:if>
</div>


<!-- 내 정보 수정 모달 창 -->
<!-- Modal -->
<div class="modal modal-center fade" id="memberEditModal" role="dialog">
	<div class="modal-dialog modal-md modal-center">
		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">내 정보 수정</h4>
			</div>
			<div class="modal-body" id="modalBody" style="height: auto;">
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
		</div>

	</div>
</div>




