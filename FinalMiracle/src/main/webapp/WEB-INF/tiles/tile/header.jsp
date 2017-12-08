<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.net.InetAddress"%>

<%-- ===== tiles 중 header 페이지 만들기  ===== --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	// === 서버 IP 주소 알아오기 === //
	InetAddress inet = InetAddress.getLocalHost();
	String serverIP = inet.getHostAddress();
	int portnumber = request.getServerPort();

	String serverName = "http://" + serverIP + ":" + portnumber;
%>

<style type="text/css">
</style>


<div style="border: 3px solid pink;">
	<!-- 로고(클릭시 메인페이지-일정관리 이동) -->
	<div style="border: 3px solid green; float: left;">
		<a href="<%=request.getContextPath()%>/doList.mr">
			<img src="<%=request.getContextPath()%>/resources/images/logo.png" height="100px;" width="250px;">
		</a>
	</div>

	<!-- 통합검색메뉴 -->
	<div style="border: 1px solid blue; float: left;">
		통합검색 : <input type="text" />
	</div>

	<!-- ===== 로그인 성공한 사용자 정보 출력 ===== -->
	<c:if test="${sessionScope.loginUser != null}">
		<div
			style="border: 3px solid yellow; float: right; width: 25%; height: 100px;">
			<div style="border: 1px solid maroon;">사용자 정보</div>
			<div class="user img" style="float: left; width: 30%; height: 85%; border: 2px solid red;">
				<img src="<%= request.getContextPath() %>/resources/images/${sessionScope.loginUser.img}" style="height: 100%; width: 100%;">&nbsp;&nbsp;
			</div>
			<div class="user id" style="float: right; width: 55%; border: 1px solid blue;">
				아이디 : <span style="color: navy; font-weight: bold;">${sessionScope.loginUser.userid}</span><br/>
				회원명 : <span style="color: navy; font-weight: bold;">${sessionScope.loginUser.name}</span><br/>
				<a href="<%=request.getContextPath()%>/tmForm.mr">[ 팀 선택 ]</a>
			</div>
			<br />
			<div class="user menu" style="float: right; border: 1px solid cyan;">
				<a href="<%=request.getContextPath()%>/member_edit.mr">[내정보수정]</a> &nbsp;&nbsp; 
				<a href="<%=request.getContextPath()%>/member_logout.mr">[로그아웃]</a>
			</div>
		</div>
	</c:if>
</div>






