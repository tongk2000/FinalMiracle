<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
		html += '		<span id="span${returnMap.fvo.idx}" style="margin-left:${returnMap.fvo.depth*15}px; cursor:pointer;">'
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
		html += '</tr>'
		
		
		var $opener = $(".selectedLine", opener.document);
		var category = "${returnMap.fvo.category}";
		var depth = parseInt("${returnMap.fvo.depth}");
		
		if(category == '1') {
			$opener.after(html);
		} else if (category == '2') {
			while(1==1) {
				var $next = $opener.next();
				var depth2 = parseInt(window.opener.getThirdClass($next));
				
				if($next.find("modalFolder").hasClass("modalFolder") & depth == depth2) {
					alert(1);
					$next = $next.next();
				} else {
					alert(2);
					$next.prev().after(html);
					break;
				}
			}
		}
		
		window.opener.addLine("${returnMap.fvo.idx}"); // 살짝 깜빡여 주도록~
		window.close();
	}
</script>














