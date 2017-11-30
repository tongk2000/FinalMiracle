<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.InetAddress" %>

<%-- ===== tiles 중 header 페이지 만들기  ===== --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%  
    // === 서버 IP 주소 알아오기 === //
	InetAddress inet = InetAddress.getLocalHost();
	String serverIP = inet.getHostAddress(); 
	int portnumber = request.getServerPort();
	
	String serverName = "http://"+serverIP+":"+portnumber;
%>   

<style type="text/css">

.mydiv { display: inline-block; 
		 border: 1px solid green; }

.mydiv.logo {margin-left: 10px; float: left;
			 border: 1px solid orange; }

.mydiv.session { margin-top: 10px; float: right;
				 display: block;
				 border: 1px solid blue; }

</style>
 
<div class="mydiv logo">

	<a href="<%= request.getContextPath() %>/index.mr"><img src="<%= request.getContextPath() %>/resources/images/logo.png" height="130px;" width="280px;"></a>	
</div>

<div class="mydiv search">
	통합검색 : <input type="text"  />	
</div>

<!-- ===== 로그인 성공한 사용자 정보 출력 ===== -->
<c:if test="${sessionScope.loginUser != null}">
	<div class="mydiv session">
		<img src="<%= request.getContextPath() %>/resources/images/${sessionScope.loginUser.img}" style="height: 60px; width: 55px;">&nbsp;&nbsp;
		아이디 : <span style="color: navy; font-weight: bold;">${sessionScope.loginUser.userid}</span> &nbsp;
		회원명 : <span style="color: navy; font-weight: bold;">${sessionScope.loginUser.name}</span> &nbsp;
		<br/>
		[내정보 수정] &nbsp;&nbsp; 
		<a href="<%= request.getContextPath() %>/member_logout.mr">[로그아웃]</a>
	</div>
</c:if>