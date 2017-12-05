<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style type="text/css">
	table, th, td, input, textarea {border: solid gray 1px;}
	
	#table, #table2 {border-collapse: collapse;
	 		         width: 600px;
	 		        }
	#table th, #table td{padding: 5px;}
	#table th{width: 120px; background-color: #DDDDDD;}
	#table td{width: 480px;}
	.long {width: 470px;}
	.short {width: 120px;} 	
	
	a{color: black;}	

</style>

<script type="text/javascript">
	
	$(document).ready(function(){
		
		var idx = 
		getUserDetail();
		
	});
	

	
	
</script>

<h1>팀원 출퇴근 정보</h1>

${teamname}팀 팀원 출퇴근 보기
<br/>



<table>
	<thead>
		<tr>
			<th>팀원번호</th>
			<th>프로필사진</th>
			<th>아이디</th>
			<th>이름</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="map" items="${teamWonList}">
			<tr>
				<td>${map.twidx}</td>
				<td><a href="<%=request.getContextPath() %>/commutetw.mr?idx=${map.midx}&username=${map.username}"><img height="60px" width="60px" src="<%=request.getContextPath() %>/resources/images/${map.img}"></a></td>
				<td><a href="<%=request.getContextPath() %>/commutetw.mr?idx=${map.midx}&username=${map.username}">${map.userid}</a></td>
				<td><a href="<%=request.getContextPath() %>/commutetw.mr?idx=${map.midx}&username=${map.username}">${map.username}</a></td>
			</tr>
		</c:forEach>
	</tbody>
</table>


