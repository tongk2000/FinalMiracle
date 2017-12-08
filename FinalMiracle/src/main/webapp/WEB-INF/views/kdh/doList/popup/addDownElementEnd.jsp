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
	var result = parseInt("${returnMap.result}");
	
	if(result == 0) {
		alert("입력에 실패하였습니다.\n관리자에게 문의하세요.");
		location.href="javascript:history.back();"
	}
	if(result > 0) {
		alert("입력에 성공하였습니다.");
		var html = "";
		html += '<tr id="${returnMap.fvo.idx}" class="folder ${returnMap.fvo.groupNo} ${returnMap.fvo.depth}">'
		html += '	<td>'
		html += '		<span id="span${returnMap.fvo.idx}" style="margin-left:${returnMap.fvo.depth*20}px; cursor:pointer;">'
							<c:if test="${returnMap.fvo.category == 1}"> <!-- 폴더라면 -->
		html += '				<span class="modalFolder" id="modalIdx${returnMap.fvo.idx}">'
									<c:if test="${returnMap.fvo.fk_folder_idx != 0}"> <!-- 최상위 폴더가 아니라면 -->
		html += '						└'
									</c:if>
		html += '					<span class="modalFolder subject" id="modalIdx${returnMap.fvo.idx}">${returnMap.fvo.subject}</span>'
		html += '				</span>'
							</c:if>
							<c:if test="${returnMap.fvo.category == 2}"> <!-- 할일이라면 -->
								<c:if test="${returnMap.fvo.status == 0}"> <!-- 완료된 할일이라면 -->
		html += '					└<input type="checkbox" id="status${returnMap.fvo.idx}" class="status" checked/>'
								</c:if>
								<c:if test="${returnMap.fvo.status == 1}"> <!-- 미완료된 할일이라면 -->
		html += '					└<input type="checkbox" id="status${returnMap.fvo.idx}" class="status"/>'
								</c:if>
		html += '				<span class="modalTask subject" id="subject${returnMap.fvo.idx}">${returnMap.fvo.subject}</span>'
							</c:if>
		html += '		</span>'
		html += '	</td>'
					<c:if test="${returnMap.fvo.dayCnt == 0}"> <!-- 시작일 전이라면 -->
		html += '		<td style="background-color:lightgreen;">${returnMap.fvo.startDate}</td>'
		html += '		<td style="background-color:lightgreen;">${returnMap.fvo.lastDate}</td>'
					</c:if>
					<c:if test="${returnMap.fvo.dayCnt == 1}"> <!-- 진행중이라면 -->
		html += '		<td style="background-color:green;">${returnMap.fvo.startDate}</td>'
		html += '		<td style="background-color:green;">${returnMap.fvo.lastDate}</td>'
					</c:if>
					<c:if test="${returnMap.fvo.dayCnt == -1}"> <!-- 기한이 지났다면 -->
		html += '		<td style="background-color:red;">${returnMap.fvo.startDate}</td>'
		html += '		<td style="background-color:red;">${returnMap.fvo.lastDate}</td>'
					</c:if>
		html += '	<td>${returnMap.fvo.importance}</td>'
		html += '	<td></td>'
		html += '	<td></td>'
					<c:forEach var="pageDate" items="${returnMap.pageDateList}">
						<fmt:parseNumber var="startDate" value="${returnMap.fvo.startDate.replace('-','')}" integerOnly="true"/>
						<fmt:parseNumber var="lastDate" value="${returnMap.fvo.lastDate.replace('-','')}" integerOnly="true"/>
						<fmt:parseNumber var="day" value="${pageDate.day}" integerOnly="true"/>
						
						<c:if test="${startDate <= day and day <= lastDate}">
							<c:if test="${returnMap.fvo.dayCnt == 0}"> <!-- 시작일 전이라면 -->
		html += '				<td style="background-color:lightgreen; border-top:none; border-bottom:none;"></td>'
							</c:if>
							<c:if test="${returnMap.fvo.dayCnt == 1}"> <!-- 진행중이라면 -->
		html += '				<td style="background-color:green; border-top:none; border-bottom:none;"></td>'
							</c:if>
							<c:if test="${returnMap.fvo.dayCnt == -1}"> <!-- 기한이 지났다면 -->
		html += '				<td style="background-color:red; border-top:none; border-bottom:none;"></td>'
							</c:if>
						</c:if>
						<c:if test="${startDate > day or day > lastDate}">
		html += '			<td style="border-top:none; border-bottom:none;"></td>'
						</c:if>
					</c:forEach>
		html += '</tr>'
		
		
		var $opener = $(".selectedLine", opener.document); // 추가요소의 부모요소 선택자를 잡음
		var category = "${returnMap.fvo.category}"; // 추가요소의 분류(1:폴더, 2:할일)을 저장함
		var depth = parseInt("${returnMap.fvo.depth}"); // 추가요소의 깊이를 저장함
		
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
		
		window.opener.addLine("${returnMap.fvo.idx}"); // 살짝 깜빡여 주도록~
		window.close();
	}
</script>














