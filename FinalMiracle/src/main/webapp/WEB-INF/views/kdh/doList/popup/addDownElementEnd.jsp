<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resources/BootStrapStudy/css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/jqueryuicss/jquery-ui.css" />

<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/jquery-2.0.0.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/BootStrapStudy/js/bootstrap.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/jqueryuijs/jquery-ui.js"></script>

<script>
	var result = parseInt("${endMap.result}");
	alert(result);
	if(result == 0) {
		alert("입력에 실패하였습니다.\n관리자에게 문의하세요.");
		location.href="javascript:history.back();"
	}
	if(result > 0) {
		alert("입력에 성공하였습니다.");
		var html = "";
		html += '<tr id="${endMap.fvo.idx}" class="element ${endMap.fvo.groupNo} ${endMap.fvo.depth}">'
		html += '	<td>'
		html += '		<input type="hidden" id="fk_folder_idx" name="fk_folder_idx" value="${endMap.fvo.fk_folder_idx}" />'
		html += '		<input type="hidden" id="fk_folder_idx" name="fk_folder_idx" value="${endMap.fvo.downCnt}" />'
		html += '		<span id="span${endMap.fvo.idx}" style="margin-left:${endMap.fvo.depth*20}px; cursor:pointer;">'
							<c:if test="${endMap.fvo.category == 1}"> <!-- 폴더라면 -->
		html += '				<span class="modalFolder">'
		html += '					▷'
		html += '				</span>'
		html += '				<span class="modalFolder subject">${endMap.fvo.subject}</span>'
							</c:if>
							<c:if test="${endMap.fvo.category == 2}"> <!-- 할일이라면 -->
		html += '				└<input type="checkbox" id="status${endMap.fvo.idx}" class="status"/>'
		html += '				<span class="modalTask subject" id="subject${endMap.fvo.idx}">${endMap.fvo.subject}</span>'
							</c:if>
		html += '		</span>'
		html += '	</td>'
					
					<c:if test="${endMap.fvo.dayCnt == 0}"> <!-- 시작일 전이라면 -->
		html += '		<td class="dateColor ${endMap.fvo.dayCnt}" style="background-color:lightgreen;">${endMap.fvo.startDate}</td>'
		html += '		<td class="dateColor ${endMap.fvo.dayCnt}" style="background-color:lightgreen;">${endMap.fvo.lastDate}</td>'
					</c:if>
					<c:if test="${endMap.fvo.dayCnt == 1}"> <!-- 진행중이라면 -->
		html += '		<td class="dateColor ${endMap.fvo.dayCnt}" style="background-color:green;">${endMap.fvo.startDate}</td>'
		html += '		<td class="dateColor ${endMap.fvo.dayCnt}" style="background-color:green;">${endMap.fvo.lastDate}</td>'
					</c:if>
					<c:if test="${endMap.fvo.dayCnt == -1}"> <!-- 기한이 지났다면 -->
		html += '		<td class="dateColor ${endMap.fvo.dayCnt}" style="background-color:red;">${endMap.fvo.startDate}</td>'
		html += '		<td class="dateColor ${endMap.fvo.dayCnt}" style="background-color:red;">${endMap.fvo.lastDate}</td>'
					</c:if>
		html += '	<td>${endMap.fvo.importance}</td>'
					
		html += '	<td></td>'
		html += '	<td></td>'
					
					<c:forEach var="pageDate" items="${map.pageDateList}">
						<fmt:parseNumber var="startDate" value="${endMap.fvo.startDate.replace('-','')}" integerOnly="true"/>
						<fmt:parseNumber var="lastDate" value="${endMap.fvo.lastDate.replace('-','')}" integerOnly="true"/>
						<fmt:parseNumber var="day" value="${endMap.pageDate.day}" integerOnly="true"/> <!-- 희안하게 위에껀 못쓰고 여기서 다시 해줘야함; -->
						
		html += '		<td class="pageDateLine ${day}" style="border-left:0.5px solid lightgray;'
							<c:if test="${endMap.pageDate.dotw == '토' || endMap.pageDate.dotw == '일'}">
		html += '				background-color:#ffcccc;'
							</c:if>
		html += '		" align="center">'
							
							<c:if test="${startDate <= day and day <= lastDate}"> <!-- 시작일 이후, 마감일 이전 이라면 -->
								<c:if test="${endMap.fvo.dayCnt == 0}"> <!-- 시작일 전이라면 -->
		html += '					<div class="dateColor ${day} ${endMap.fvo.dayCnt}" style="height:19px; width:100%; background-color:lightgreen;"></div>'
								</c:if>
								<c:if test="${endMap.fvo.dayCnt == 1}"> <!-- 진행중이라면 -->
		html += '					<div class="dateColor ${day} ${endMap.fvo.dayCnt}" style="height:19px; width:100%; background-color:green;"></div>'
								</c:if>
								<c:if test="${endMap.fvo.dayCnt == -1}"> <!-- 기한이 지났다면 -->
		html += '					<div class="dateColor ${day} ${endMap.fvo.dayCnt}" style="height:19px; width:100%; background-color:red;"></div>'
								</c:if>
							</c:if>
		html += '		</td>'
					</c:forEach>
		html += '</tr>'
		
		
		var $opener = $(".selectedLine", opener.document); // 추가요소의 부모요소 선택자를 잡음
		var category = "${endMap.fvo.category}"; // 추가요소의 분류(1:폴더, 2:할일)을 저장함
		var depth = parseInt("${endMap.fvo.depth}"); // 추가요소의 깊이를 저장함
		
		var $downCnt = $opener.find(".downCnt");
		var downCntVal = parseInt($downCnt.val());
		$downCnt.val(downCntVal + 1);
		$opener.find(".foldingIcon").text("▼");
		
		if(category == '1') { // 추가요소가 폴더라면
			$opener.after(html); // 다음칸에 넣음
		} else if (category == '2') { // 추가요소가 할일이라면 같은 깊이의 폴더 바로 다음, 혹은 폴더가 없다면 부모요소의 다음에 넣음. 
			var $this = $opener;
			while(1==1) {
				if($this.next().attr("id") == undefined) {
					break;
				}
				var depth2 = parseInt(window.opener.getThirdClass($this.next()) ); // 다음 요소의 깊이를 저장함
				
				if($this.next().find(".modalFolder").hasClass("modalFolder") & depth == depth2) { // 다음 요소가 폴더이면서 깊이가 같다면
					$this = $this.next();
				} else if(depth < depth2) { // 다음 요소의 깊이가 더 깊다면
					$this = $this.next();
				} else {
					break;
				}
			}
			$this.after(html);
		}
		
		window.opener.todayLine();
		window.opener.addLine("${endMap.fvo.idx}"); // 살짝 깜빡여 주도록~
		window.close();
	}
</script>














