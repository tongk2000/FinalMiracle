<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style type="text/css">
	table, th, td{
		border: solid gray 1px;
		text-align: center;
		padding-right: 10px;
		padding-left: 10px;
		padding-bottom: 5px;
		padding-top: 5px;
	}
	a{color: black;}	
	th{font-size: 20px;}
	td{font-size: 17px;}

</style>

<script type="text/javascript">
	
	$(document).ready(function(){
		
		getUserDetail();
		
	});
	

	
	
</script>
<div align="center" style="margin-top: 5%;">
	<div align="center" style="border: 0px solid green; width: 50%;">
		<img height="140px" width="140px" src="<%=request.getContextPath() %>/resources/images/${timg}">&nbsp;
		<span style="font-size: 40px; font: bold; vertical-align: middle;">팀 ${teamname}</span>
	</div>

	
	<div align="center" style="border: 0px solid black; width: 50%;">
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
				<c:if test="${not empty teamWonList}">
					<c:forEach var="map" items="${teamWonList}">
						<tr>
							<td>${map.twidx}</td>
							<td><a href="<%=request.getContextPath() %>/commutetw.mr?idx=${map.twidx}&username=${map.username}"><img height="70px" width="70px" src="<%=request.getContextPath() %>/resources/images/${map.img}"></a></td>
							<td><a href="<%=request.getContextPath() %>/commutetw.mr?idx=${map.twidx}&username=${map.username}">${map.userid}</a></td>
							<td><a href="<%=request.getContextPath() %>/commutetw.mr?idx=${map.twidx}&username=${map.username}">${map.username}</a></td>
							<td>${map.regdate}</td>
							<td>${map.disdate}</td>
						</tr>
					</c:forEach>
				</c:if>
				<c:if test="${empty teamWonList}">
					<tr>
						<td colspan="6">팀원이 없습니다</td>
					</tr>
				</c:if>
			</tbody>
		</table>
	</div>
	<div style="border: 0px solid black; width: 20%; margin-top: 10px;">
	<a class="btn btn-sm btn-warning" href="javascript:history.back()">뒤로가기</a>
	</div>
</div>
