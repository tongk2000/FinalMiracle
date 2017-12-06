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
	.img {
		width:25px;
		height:25px;
	}
	div.min{
		height:10px;
		opacity:1.0;
	} 
	.subjectstyle {font-weight: bold;
    	           color: gray;
    	           cursor: pointer; }
</style>
<script src="<%= request.getContextPath() %>/resources/js/jquery-2.0.0.js"></script>
<title>Mind 게시판 입니다!</title>
</head>
<body>
	<div align="center" style="width:80%; margin:auto;">
		<h2>마음의 소리 게시판</h2>
		<form name="frm">
			<select id="searchType" name="searchType" style="font-size:12pt;">
				<option value="fk_userid">아이디</option>
				<option value="subject">제목</option>
			</select>
			<input type="text" id="searchString" name="searchString" />
			<button type="button" id="btnClick" onClick="goSearch();">검색</button><br/>
			<div><div class="min"><div class="min"><div class="min"><div class="min"><div class="min"><div class="min">
				<div id="displayList" style="background-color:red; width:150px; margin-left: 28px; border-top: 0px; border: solid black 1px;"></div>
			</div></div></div></div></div></div></div>
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
						<c:forEach var="md" items="${list}" varStatus="status">
							<tr>
								<td>${status.count}</td>	<!-- 번호 -->
								<td><img class="img" src="<%= request.getContextPath()%>/resources/images/${md.img}"/> 
								<span class="userid" >${md.fk_userid}</span></td>	<!-- 아이디 -->
								<td>${md.subject}</td>		<!-- 제목 -->
								<td>${md.regday}</td>		<!-- 날짜 -->
								<td>${md.readcount}</td>	<!-- 조회수-->
							</tr>
						</c:forEach>
					</c:if>	
				</tbody>
			</table>
		</form>
		${pagebar}
	</div>
	<script>
		$(document).ready(function(){
			keep();
			$("#displayList").hide();
			$("#searchString").keyup(function(){
				if($("#searchType").val()==null||$("#searchType").val()=="") {
					$("#searchType").val("fk_userid");
				}
				var data_form = {"searchString":$("#searchString").val(), "searchType":$("#searchType").val()};
				$.ajax({
					url:"mindListJSON.mr",
					type:"get",
					data:data_form,
					dataType:"JSON",
					success: function(data) {
						var resultHTML ="";
						if(data.length > 0) { // 검색된 데이터가 있는 경우라면
							$.each(data, function(entryIndex, entry){
								var wordstr = entry.search;
								var index = wordstr.toLowerCase().indexOf( $("#searchString").val().toLowerCase() );
								var len = $("#searchString").val().length;
								var result = "";
								result = "<span class='first' style='color:blue;'>" +wordstr.substr(0, index)+ "</span>" + "<span class='second' style='color:red; font-weight:bold;'>" +wordstr.substr(index, len)+ "</span>" + "<span class='third' style='color:blue;'>" +wordstr.substr(index+len, wordstr.length - (index+len) )+ "</span>";  
								resultHTML += "<span style='cursor:pointer;'>"+ result +"</span><br/>"; 
							});
							$("#displayList").html(resultHTML);
							$("#displayList").show();
						}
						else {
							// 검색된 데이터가 존재하지 않는 경우라면
							$("#displayList").hide();
						} // end of if ~ else ----------------
					}, // end of success: function()----------
					error: function(){
						
					}
				}); // end of $.ajax()------------------------
			}); // end of keyup(function(){})-----------------
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
			frm.action="<%=request.getContextPath()%>/mindList.mr";
			frm.method="get";
			frm.submit();
		}
	</script>
</body>
</html>