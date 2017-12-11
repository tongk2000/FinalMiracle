<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<html>
<head>
<meta charset="UTF-8">
<title>자유게시판</title>

<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/jqueryuicss/jquery-ui.css" />
<link href="<%=request.getContextPath() %>/resources/summernote/summernote.css" rel="stylesheet">

<script type="text/javascript" src="<%= request.getContextPath() %>/resources/jqueryuijs/jquery-ui.js"></script>
<script src="<%=request.getContextPath() %>/resources/summernote/summernote.js"></script>
<script src="<%=request.getContextPath() %>/resources/summernote/lang/summernote-ko-KR.js"></script>

<style type="text/css">

	table tr, td {
		border: 1px dashed gray;
		border-left: none;
		border-right: none;
	}
	
	table th {
		border: 1px solid gray;
		border-left: none;
		border-right: none;
		background-color: lightgray;
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
		// ===================================== *** summernote text area 편집기 불러오기 *** ==============
		$('.summernote').summernote({
		      height: 300,          // 기본 높이값
		      minHeight: null,      // 최소 높이값(null은 제한 없음)
		      maxHeight: null,      // 최대 높이값(null은 제한 없음)
		      focus: true,          // 페이지가 열릴때 포커스를 지정함
		      lang: 'ko-KR'         // 한국어 지정(기본값은 en-US)
	    });
		
		$(".subject").bind("mouseover", function(event){
			var $target = $(event.target);
			$target.addClass("subjectStyle");
		});
		$(".subject").bind("mouseout", function(event){
			var $target = $(event.target);
			$target.removeClass("subjectStyle");
		});
		searchKeep();
	});  // end of $(document).ready() ---------------------------------
	
	function searchKeep(){
		<c:if test="${(colname != 'null' && not empty colname) && (search != 'null' && not empty search)}">
			$("#colname").val("${colname}");
			$("#search").vla("${search}");
		</c:if>
	}
	
	function goView(idx, gobackURL){
		var frm = document.idxFrm;
		frm.idx.value = idx;
		frm.gobackURL.value = gobackURL;
		
		frm.method = "get";
		frm.action = "<%= request.getContextPath() %>/freeView.mr";
		frm.submit();
	}
	
	function goSearch(){
		var frm = document.searchFrm;
		var search = $("#search").val();
		
		if(search.trim()==""){
			alert("검색어를 입력하세요!!");
			return;
		} else {
			frm.submit();
		}
	}
	
</script>

</head>

<body>
	<div style="border: 1px solid pink; margin-left: 10%; width: 90%;">
		<h1>자유게시판</h1>
		<!-- 글 검색용 폼 생성 -->
		<div>
			<form name="searchFrm" action="<%= request.getContextPath() %>/freeList.mr" method="get">
				<select name="colname" id="colname">
					<option value="subject">제목</option>
					<option value="content">내용</option>
					<option value="userid">아이디</option>
					<option value="name">성명</option>
				</select>
				<input type="text" name="search" id="search" size="40px" />
				<button type="button" onClick="goSearch();">검색</button>
			</form>
		</div>
		<br/>
		<div style="width: 100%;">
			<table id="freeboard" style="width: 90%;">
				<thead>
					<tr>
						<th>글번호</th>
						<th>아이디</th>
						<th>성명</th>
						<th>글제목</th>
						<th>조회수</th>
						<th>등록일자</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="free" items="${freeList}" varStatus="status">
						<tr>
							<td>${free.idx}</td>
							<td>${free.userid}</td>
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
	<div style="width: 80%; margin-left: 10%;">
		${pagebar}
	</div>
	
	<!-- 해당 글 조회용 폼 생성 -->
	<form name="idxFrm">
		<input type="hidden" name="idx" />
		<input type="hidden" name="gobackURL" />
	</form>
	
	

</body>
</html>



