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
	
	a{text-decoration: none;}	

</style>

<script type="text/javascript">
	
	function welcome() {
		
		location.href="<%= request.getContextPath() %>/commutestart.mr";
		
	}
	
	function goodbye() {
		
		location.href="<%= request.getContextPath() %>/commuteend.mr";
		
	}
	
	
	
</script>



<h1>출퇴근 체크</h1>

홍길동님의 출퇴근 내역 입사일자 2017-10-10
<br/>

<button id="start" name="start" onclick="welcome()">출근</button>
<button id="end" name="end" onclick="goodbye()">톼근</button>

<br/>

월별보기
<select id="month" onchange="begin()">
	<option value="all">전체</option>
	<c:forEach begin="1" end="12" varStatus="status">
		<option value="${status.count}">${status.count}월</option>
	</c:forEach>
</select>

<table>
	<thead>
		<tr>
			<th>일자</th>
			<th>출근시간</th>
			<th>퇴근시간</th>
			<th>근무시간</th>
			<th>비고</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="map" items="${commuteList}">
			<tr>
				<td>${map.wt_date}</td>
				<td>${map.stime}</td>
				<td>${map.etime}</td>
				<td>${map.whour} ${map.wminute}</td>
				<c:if test="${map.wstatus == 0}">
					<td> </td>
				</c:if>
				<c:if test="${map.wstatus == 1}">
					<td>지각</td>
				</c:if>
				<c:if test="${map.wstatus == 2}">
					<td>조퇴</td>
				</c:if>
				<c:if test="${map.wstatus == 3}">
					<td>결근</td>
				</c:if>
				<c:if test="${map.wstatus == 4}">
					<td>지각,조퇴</td>
				</c:if>
			</tr>
		</c:forEach>
	</tbody>
</table>


pagebar

