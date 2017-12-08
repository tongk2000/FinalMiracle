<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유게시판</title>

<style type="text/css">

	table tr th, td {
		border: 1px solid gray;
		padding: 5px;
	}
	
	.subjectStyle {
		color: dimgray;
		font-weight: bold;
		font-size: 12pt;
		cursor: pointer;
	}

</style>

<script type="text/javascript">
	$(document).ready(function(){
		$(".subject").bind("mouseover", function(event){
			var $target = $(event.target);
			$target.addClass("subjectStyle");
		});
		$(".subject").bind("mouseout", function(event){
			var $target = $(event.target);
			$target.removeClass("subjectStyle");
		});
	});  // end of $(document).ready() ---------------------------------
	
	function goView(idx, gobackURL){
		var frm = document.idxFrm;
		frm.idx.value = idx;
		frm.gobackURL.value = gobackURL;
		
		frm.method = "get";
		frm.action = "<%= request.getContextPath() %>/freeView.mr";
		frm.submit();
	}
	
</script>

</head>

<body>
	<div style="border: 1px solid pink; margin-left: 10%;">
		<h1>자유게시판</h1>
		<!-- 글 검색용 폼 생성 -->
		<div>
			<form name="searchFrm" action="<%= request.getContextPath() %>/freeList.mr" method="get">
				<select name="colname" id="colname">
					<option value="subject">제목</option>
					<option value="content">내용</option>
					<option value="userid">작성자</option>
				</select>
				<input type="text" name="search" id="search" size="40px" />
				<button type="button" onClick="goSearch();">검색</button>
			</form>
		</div>
		<br/>
		<div>
			<table id="freeboard">
				<thead>
					<tr>
						<th>글번호</th>
						<th>아이디</th>
						<th>작성자</th>
						<th>글제목</th>
						<th>조회수</th>
						<th>등록일자</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="free" items="${freeList}" varStatus="status">
						<tr>
							<td>${free.idx}</td>
							<td>
								${free.userid}
							</td>
							<td>${free.name}</td>
							<td class="subject" onClick="goView('${free.idx}','${gobackURL}')">${free.subject}</td>
							<td>${free.readCnt}</td>
							<td>${free.regDate}</td>
						<tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<br/>
		<div>
			<button type="button" onClick="javascript:location.href='<%= request.getContextPath() %>/freeList.mr'">글목록</button>
			<button type="button" onClick="javascript:location.href='<%= request.getContextPath() %>/freeAdd.mr'">글쓰기</button>
		</div>
		<br/>
	</div>
	
	<!-- 페이지 바 만들기 -->
	
	
	<!-- 해당 글  조회용 폼 생성 -->
	<form name="idxFrm">
		<input type="hidden" name="idx" />
		<input type="hidden" name="gobackURL" />
	</form>
	
	

</body>
</html>



