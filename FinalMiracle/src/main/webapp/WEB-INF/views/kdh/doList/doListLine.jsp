<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:if test="${not empty map.doList}"> <!-- 프로젝트 리스트가 있다면 -->
	<c:forEach var="dvo" items="${map.doList}">
		<tr id="${dvo.idx}"
			<c:if test="${dvo.category == 1}">
				style="font-size:11pt; font-weight:bold;"
			</c:if>
		class="element ${dvo.groupNo} ${dvo.depth} trLine">
			<td>
				<input type="hidden" class="fk_folder_idx" value="${dvo.fk_folder_idx}" />
				<input type="hidden" class="downCnt" value="${dvo.downCnt}" />
				<span id="span${dvo.idx}" style="margin-left:${dvo.depth*20}px;">
					<c:if test="${dvo.category == 1}"> <!-- 폴더라면 -->
						<span class="foldingIcon" style="cursor:default;">
							<c:if test="${dvo.downCnt > 0}"> <!-- 하위요소가 있다면 -->
								▼
							</c:if>
							<c:if test="${dvo.downCnt == 0}"> <!-- 하위요소가 없다면 -->
								▷
							</c:if>
						</span>
						<span class="modalFolder subject pointer" id="subject${dvo.idx}">${dvo.subject}</span>
					</c:if>
					<c:if test="${dvo.category == 2}"> <!-- 할일이라면 -->
						<c:if test="${dvo.status == 0}"> <!-- 완료된 할일이라면 -->
							└<input type="checkbox" id="status${dvo.idx}" class="status" checked/>
						</c:if>
						<c:if test="${dvo.status == 1}"> <!-- 미완료된 할일이라면 -->
							└<input type="checkbox" id="status${dvo.idx}" class="status"/>
						</c:if>
						<span class="modalTask subject pointer" id="subject${dvo.idx}">${dvo.subject}</span>
					</c:if>
				</span>
			</td>
			
			<td>${dvo.ftCnt}</td>
			<td>${dvo.ffCnt}</td>
			<td>${dvo.fcCnt}</td>
			
			<c:if test="${dvo.status == 1}"> <!-- 미완료된 할일이라면 -->
				<c:if test="${dvo.dayCnt == 0}"> <!-- 시작일 전이라면 -->
					<td class="dateColor ${dvo.dayCnt} startDateTd" style="background-color:lightgreen;">${dvo.startDate}</td>
					<td class="dateColor ${dvo.dayCnt} lastDateTd" style="background-color:lightgreen;">${dvo.lastDate}</td>
				</c:if>
				<c:if test="${dvo.dayCnt == 1}"> <!-- 진행중이라면 -->
					<td class="dateColor ${dvo.dayCnt} startDateTd" style="background-color:green;">${dvo.startDate}</td>
					<td class="dateColor ${dvo.dayCnt} lastDateTd" style="background-color:green;">${dvo.lastDate}</td>
				</c:if>
				<c:if test="${dvo.dayCnt == -1}"> <!-- 기한이 지났다면 -->
					<td class="dateColor ${dvo.dayCnt} startDateTd" style="background-color:red;">${dvo.startDate}</td>
					<td class="dateColor ${dvo.dayCnt} lastDateTd" style="background-color:red;">${dvo.lastDate}</td>
				</c:if>
			</c:if>
			<c:if test="${dvo.status == 0}"> <!-- 완료된 할일이라면 -->
				<td class="dateColor ${dvo.dayCnt}" style="background-color:gray;">${dvo.startDate}</td>
				<td class="dateColor ${dvo.dayCnt}" style="background-color:gray;">${dvo.lastDate}</td>
			</c:if>
			<td style="border-right:3px solid black;">${dvo.importance}</td>
						
			<c:forEach var="pageDate" items="${map.pageDateList}">
				<fmt:parseNumber var="startDate" value="${dvo.startDate.replace('-','')}" integerOnly="true"/>
				<fmt:parseNumber var="lastDate" value="${dvo.lastDate.replace('-','')}" integerOnly="true"/>
				<fmt:parseNumber var="day" value="${pageDate.day}" integerOnly="true"/> <!-- 희안하게 위에껀 못쓰고 여기서 다시 해줘야함; -->
				
				<td class="pageDateLine ${day}" style="border-right:0.5px solid lightgray; height:10px; <%-- 여기에 height 줘야만 밑에서 div height 에 % 가 먹음 --%>
					<c:if test="${pageDate.dotw == '토' || pageDate.dotw == '일'}">
						background-color:#ffcccc;
					</c:if>
					<c:if test="${fn:substring(pageDate.day, 6, 8) == '01'}">
						border-left:2px solid #ff66ff;
					</c:if>
				" align="center">
					
					<c:if test="${startDate <= day and day <= lastDate}"> <!-- 시작일 이후, 마감일 이전 이라면 -->
						<c:if test="${dvo.status == 1}"> <!-- 미완료된 할일이라면 -->
							<c:if test="${dvo.dayCnt == 0}"> <!-- 시작일 전이라면 -->
								<div class="dateColor ${day} ${dvo.dayCnt}" style="height:85%; width:100%; background-color:lightgreen;"></div>
							</c:if>
							<c:if test="${dvo.dayCnt == 1}"> <!-- 진행중이라면 -->
								<div class="dateColor ${day} ${dvo.dayCnt}" style="height:85%; width:100%; background-color:green;"></div>
							</c:if>
							<c:if test="${dvo.dayCnt == -1}"> <!-- 기한이 지났다면 -->
								<div class="dateColor ${day} ${dvo.dayCnt}" style="height:85%; width:100%; background-color:red;"></div>
							</c:if>
						</c:if>
						<c:if test="${dvo.status == 0}"> <!-- 완료된 할일이라면 -->
							<div class="dateColor ${day} ${dvo.dayCnt}" style="height:85%; width:100%; background-color:gray;"></div>
						</c:if>
					</c:if>
				</td>
			</c:forEach>
		</tr>
	</c:forEach>
</c:if>