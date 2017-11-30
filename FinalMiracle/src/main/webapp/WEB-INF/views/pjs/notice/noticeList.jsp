<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
	table {
		
		border: 1px solid black;
	}
	tr, th, td {
		border: 1px solid black;
		border-collapse:none;
	}
	td, th {
		text-align:center;
	}
</style>
<script src="<%= request.getContextPath() %>/resources/js/jquery-2.0.0.js"></script>
<title>Notice 게시판 입니다!</title>
</head>
<body>
	<div class="container">
		<div align="center" style="width:80%; margin:auto;">
			<h2>공지사항 게시판</h2>
			<form name="frm">
				<select id="choice" name="searchType" style="font-size:12pt;">
					<option value="fk_userid">아이디</option>
					<option value="subject" selected>제목</option>
				</select>
				<input type="text" id="searchString" name="searchString" />
				<button type="button" id="btnClick" onClick="goSearch();">검색</button><br/>
				<div id="displayList"></div><br/>
				<table style="width:100%;">
					<thead>
						<tr>
							<th>번호</th>		<!-- 번호 -->
							<th>아이디</th>	<!-- 아이디 -->
							<th>제목</th>		<!-- 제목 -->
							<th>글쓴 시간</th>	<!-- 글쓴 시간 -->
							<th>조회수</th>	<!-- 조회수-->
						</tr>
					</thead>
					<tbody>
						<c:if test="${empty list}">
							<tr>
								<td colspan="6">데이터가 없습니다.</td>
							</tr>
						</c:if>
						<c:if test="${not empty list}">
							<c:forEach var="nt" items="${list}" varStatus="status">
								<tr>
									<td>${status.count}</td>	<!-- 번호 -->
									<td>${nt.fk_userid}</td>	<!-- 아이디 -->
									<td>${nt.subject}</td>		<!-- 제목 -->
									<td>${nt.regday}</td>		<!-- 날짜 -->
									<td>${nt.readcount}</td>	<!-- 조회수-->
								</tr>
							</c:forEach>
						</c:if>	
					</tbody>
				</table>
			</form>
			${pagebar}
		</div>
	</div>
	<script>
		$(document).ready(function(){
			keep();
			$("#displayList").hide();
			$("#searchString").keyup(function(){
				$.getJSON("noticeListJSON.mr", {"searchString":$("#searchString").val(),
												"searchType":$("#searchType").val()}, function(data){
					alert("getJSON에는 온다.");
					var html="";
					$(data).each(function(index, item){
						var title = item;
						
						var index = title.toLowerCase().indexOf($("#searchString").val().toLowerCase() );
					//	alert("확인용 index : " + index);
					//  검색어의 길이를 반환
					    
					    var len = $("#searchString").val().length;
					    var result = "";
					    
					    result = "<span class='first' style='color:blue;'>"+title.substr(0,index)+"</span>" + "<span class='second' style='color:red; font-weight:bold;'>"+title.substr(index,len)+"</span>" + "<span class='third' style='color:blue;'>"+title.substr(index+len)+"</span>";     
					    
					    // 검색된 타이틀을 3등분으로 나눈다. -> 그래서 검색어와 일치하는 부분은 빨간색으로 나머지는 파랑색으로 !!
						
						resultHTML += "<span style='cursor:pointer;'>"+result+"</span><br/>";
					});
					$("#displayList").html(resultHTML).show();
				});
			});
		});
		function keep() {
			<c:if test="${searchType!=null&&searchType!=''}">
				$("#searchType").val("${searchType}");
			</c:if>
			<c:if test="${searchType!=null&&searchType!=''}">
				$("#searchType").val("${searchType}");
			</c:if>
		}
		function goSearch() {
			var frm = document.frm;
			frm.action="<%=request.getContextPath()%>/noticeList.mr";
			frm.method="get";
			frm.submit();
		}
	</script>
</body>
</html>