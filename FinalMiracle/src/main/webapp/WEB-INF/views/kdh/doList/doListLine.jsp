<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:if test="${not empty map.doList}"> <!-- 프로젝트 리스트가 있다면 -->
	<c:forEach var="dvo" items="${map.doList}">
		<tr id="${dvo.idx}"
			<c:if test="${dvo.category == 1}">
				style="font-weight:bold;
					<c:if test="${dvo.fk_folder_idx == 0}">
						background-color:#4882ab; color:white;
					</c:if>
				"
			</c:if>
		class="element ${dvo.groupNo} ${dvo.depth} trLine">
			<td>
				<input type="hidden" class="fk_folder_idx" value="${dvo.fk_folder_idx}" />
				<input type="hidden" class="downCnt" value="${dvo.downCnt}" />
				<input type="hidden" class="category" value="${dvo.category}" />
				<input type="hidden" class="dayCnt" value="${dvo.dayCnt}" />
				<input type="hidden" class="statusValue" value="${dvo.status}" />
				<input type="hidden" class="fullStartDate" value="${dvo.fullStartDate}" />
				<input type="hidden" class="fullLastDate" value="${dvo.fullLastDate}" />
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
							<input type="checkbox" id="status${dvo.idx}" class="status" checked/>
						</c:if>
						<c:if test="${dvo.status == 1}"> <!-- 미완료된 할일이라면 -->
							<input type="checkbox" id="status${dvo.idx}" class="status"/>
						</c:if>
						<span class="modalTask subject pointer" id="subject${dvo.idx}">${dvo.subject}</span>
					</c:if>
				</span>
			</td>
			<td style="text-align:center;">${dvo.ftCnt}</td>
			<td style="text-align:center;">${dvo.ffCnt}</td>
			<td style="text-align:center;">${dvo.fcCnt}</td>
			
			<c:if test="${dvo.status == 1}"> <!-- 미완료된 할일이라면 -->
				<c:if test="${dvo.dayCnt == 0}"> <!-- 시작일 전이라면 -->
					<td class="dateColor ${dvo.dayCnt} startDateTd" style="background-color:#cce6ff; text-align:center;">${dvo.startDate}</td>
					<td class="dateColor ${dvo.dayCnt} lastDateTd" style="background-color:#cce6ff; text-align:center;">${dvo.lastDate}</td>
				</c:if>
				<c:if test="${dvo.dayCnt == 1}"> <!-- 진행중이라면 -->
					<td class="dateColor ${dvo.dayCnt} startDateTd" style="background-color:#d6f5d6; text-align:center;">${dvo.startDate}</td>
					<td class="dateColor ${dvo.dayCnt} lastDateTd" style="background-color:#d6f5d6; text-align:center;">${dvo.lastDate}</td>
				</c:if>
				<c:if test="${dvo.dayCnt == -1}"> <!-- 기한이 지났다면 -->
					<td class="dateColor ${dvo.dayCnt} startDateTd" style="background-color:#ffcccc; text-align:center;">${dvo.startDate}</td>
					<td class="dateColor ${dvo.dayCnt} lastDateTd" style="background-color:#ffcccc; text-align:center;">${dvo.lastDate}</td>
				</c:if>
			</c:if>
			<c:if test="${dvo.status == 0}"> <!-- 완료된 할일이라면 -->
				<td class="dateColor ${dvo.dayCnt}" style="background-color:#d9d9d9; text-align:center;">${dvo.startDate}</td>
				<td class="dateColor ${dvo.dayCnt}" style="background-color:#d9d9d9; text-align:center;">${dvo.lastDate}</td>
			</c:if>
			<td style="border-right:3px solid #cce6ff; text-align:center; height:10px;">
				<div style="height:100%; width:100%; position:relative">
					<div style="z-index:5; position:absolute; height:100%; width:${dvo.importance*10}%; background-color:hsl(300, 100%, 93%);"></div>
					<div style="z-index:10; position:absolute; width:100%;">${dvo.importance}</div>
				</div>
			</td>
						
			<c:forEach var="pageDate" items="${map.pageDateList}">
				<fmt:parseNumber var="startDate" value="${dvo.startDate.replace('.','')}" integerOnly="true"/>
				<fmt:parseNumber var="lastDate" value="${dvo.lastDate.replace('.','')}" integerOnly="true"/>
				<fmt:parseNumber var="day" value="${pageDate.day}" integerOnly="true"/> <!-- 희안하게 위에껀 못쓰고 여기서 다시 해줘야함; -->
				
				<td class="pageDateLine ${day}" style="border-right:0.5px solid lightgray; height:10px; <%-- 여기에 height 줘야만 밑에서 div height 에 % 가 먹음 --%>
					<c:if test="${pageDate.dotw == '토' || pageDate.dotw == '일'}">
						background-color:#fff3e6;
					</c:if>
					<c:if test="${fn:substring(pageDate.day, 4, 6) == '01'}">
						border-left:2px solid #ff66ff;
					</c:if>
				" align="center">
					
					<c:if test="${startDate <= day and day <= lastDate}"> <!-- 시작일 이후, 마감일 이전 이라면 -->
						<c:if test="${dvo.status == 1}"> <!-- 미완료된 할일이라면 -->
							<c:if test="${dvo.dayCnt == 0}"> <!-- 시작일 전이라면 -->
								<div class="dateColor ${day} ${dvo.dayCnt}" style="height:85%; width:100%; background-color:#cce6ff;"></div>
							</c:if>
							<c:if test="${dvo.dayCnt == 1}"> <!-- 진행중이라면 -->
								<div class="dateColor ${day} ${dvo.dayCnt}" style="height:85%; width:100%; background-color:#d6f5d6;"></div>
							</c:if>
							<c:if test="${dvo.dayCnt == -1}"> <!-- 기한이 지났다면 -->
								<div class="dateColor ${day} ${dvo.dayCnt}" style="height:85%; width:100%; background-color:#ffcccc;"></div>
							</c:if>
						</c:if>
						<c:if test="${dvo.status == 0}"> <!-- 완료된 할일이라면 -->
							<div class="dateColor ${day} ${dvo.dayCnt}" style="height:85%; width:100%; background-color:#d9d9d9;"></div>
						</c:if>
					</c:if>
				</td>
			</c:forEach>
		</tr>
	</c:forEach>
</c:if>