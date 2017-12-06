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
		
		
		
		if(${not empty month && month != null}){
		
			$("#month").val("${month}");
		}
		
		
	});
	
	
	
	function search() { // 월별보기
		var frm = document.monthFrm;
	
	
		frm.method = "get";
		frm.action = "<%= request.getContextPath() %>/commutetw.mr";
		frm.submit();
		
	}
	
	
	
</script>


<div align="center" style="border: 1px solid red; width: 30%;">
	<h1>출퇴근 내역</h1>
</div>
<div align="center" style="border: 1px solid blue; width: 30%;">
	${username}님의 출퇴근 내역
</div>
<div align="center" style="border: 1px solid black; width: 30%;">
	<form name="monthFrm">
	월별보기
		<select id="month" name="month">
			<option value="">전체</option>
			<c:forEach begin="1" end="12" varStatus="status">
				<option value="${status.count}">${status.count}월</option>
			</c:forEach>
		</select>
		<button type="button" onclick="search()">검색</button>
		<input type="hidden" value="${idx}" name="idx"/>
		<input type="hidden" value="${username}" name="username"/>
	</form>
</div>
<div align="center" style="border: 1px solid green; width: 30%;">
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
</div>

<div align="center" style="border: 1px solid yellow; width: 30%;">
	${pageBar}
</div>




