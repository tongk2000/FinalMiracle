<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style type="text/css">
	table, th, td{
		border: solid gray 1px;
		text-align: center;
	}
	a{color: black;}	

</style>

<script type="text/javascript">
	
	$(document).ready(function(){
		
		var idx = 
		getUserDetail();
		
	});
	

	
	
</script>
<div align="center" style="border: 1px solid red; width: 35%;">
	<h1>팀원 출퇴근 정보</h1>
</div>
<div align="center" style="border: 1px solid green; width: 35%;">
	${teamname}팀 팀원 출퇴근 보기
</div>


<div align="center" style="border: 1px solid black; width: 35%;">
	<table>
		<thead>
			<tr>
				<th>팀원번호</th>
				<th>프로필사진</th>
				<th>아이디</th>
				<th>이름</th>
				<th>팀 합류일자</th>
				<th>팀 이탈일자</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="map" items="${teamWonList}">
				<tr>
					<td>${map.twidx}</td>
					<td><a href="<%=request.getContextPath() %>/commutetw.mr?idx=${map.twidx}&username=${map.username}"><img height="60px" width="60px" src="<%=request.getContextPath() %>/resources/images/${map.img}"></a></td>
					<td><a href="<%=request.getContextPath() %>/commutetw.mr?idx=${map.twidx}&username=${map.username}">${map.userid}</a></td>
					<td><a href="<%=request.getContextPath() %>/commutetw.mr?idx=${map.twidx}&username=${map.username}">${map.username}</a></td>
					<td>${map.regdate}</td>
					<td>${map.disdate}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>

