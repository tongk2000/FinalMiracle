<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style type="text/css">
	table, th, td{
		border-bottom: solid gray 1px;
		text-align: center;
		padding-left: 20px;
		padding-right: 20px;
		padding-top: 1px;
		padding-bottom: 1px;
	}
	a{color: black;}
	
	th{font-size: 20px;
	background-color: lightgray;}

</style>

<script type="text/javascript">
	
	$(document).ready(function(){
		
		$("#username").val("${username}");
		$("#twidx").val("${idx}");
		
		if(${not empty month && month != null}){
		
			$("#month").val("${month}");
		}
		
		
	});
	
	
	
	function searchMonth() { // 월별보기
		var frm = document.monthFrm;
		frm.method = "get";
		frm.action = "<%= request.getContextPath() %>/commutetw.mr";
		frm.submit();
		
	}
	
	
	
</script>

<div style="width: 80%; height: 80%; float: left; display: inline; border: 0px solid black; margin: 5%;">
	<div align="center" style="border: 0px solid black; width: 100%; font-size: 30px;">
		${username}님의 출퇴근 내역
	</div>
	
	<div align="center" style="border: 0px solid blue; width: 100%;">	
		<c:forEach var="detail" items="${userTeamDetail}" varStatus="status">
			<c:if test="${detail.twstatus == 2}">
				<a id="teamMember${status.count}" href="commuteteam.mr?tidx=${detail.tidx}&teamname=${detail.teamname}">팀 ${detail.teamname}의 팀원 출퇴근 내역보기</a>
			</c:if>
		</c:forEach>
	</div>	
	
	<div align="center" style="border: 0px solid green; width: 100%; height: 50px;">
	<div style="border: 0px solid red; float: left; width: 30%; margin: 5px; margin-left: 12%;">
		<form name="monthFrm" >
		월별보기
			<select id="month" name="month">
				<option value="" selected="selected">전체</option>
				<c:forEach begin="1" end="12" varStatus="status">
					<option value="${status.count}">${status.count}월</option>
				</c:forEach>
			</select>&nbsp;
			<input type="hidden" name="username" id="username"/>
			<input type="hidden" name="idx" id="twidx"/>
			<a class="btn btn-sm btn-info" onclick="searchMonth()"><span class="glyphicon glyphicon-search"></span> 검색</a>
			<!-- <button type="button" onclick="search()">검색</button> -->
		</form>
	</div>
	<div style="border: 0px solid black; float: right; width: 20%; margin: 5px; margin-right: 12%;">
	<a class="btn btn-sm btn-warning" href="javascript:history.back()">뒤로가기</a>
	</div>
	</div>
	<div align="center" style="border: 0px solid teal; width: 100%;">
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
				<c:if test="${not empty commuteList}">
					<c:forEach var="map" items="${commuteList}">
						<tr>
							<td>${map.wt_dateY}년 ${map.wt_dateM}월 ${map.wt_dateD}일</td>
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
				</c:if>
				<c:if test="${empty commuteList}">
					<td colspan="5">출퇴근 내역이 없습니다</td>
				</c:if>
			</tbody>
		</table>
	</div>
	
	<div align="center" style="border: 0px solid aqua; width: 100%;">
		${pageBar}
	</div>

</div>





