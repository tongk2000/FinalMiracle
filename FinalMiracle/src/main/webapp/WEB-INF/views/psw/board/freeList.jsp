<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<html>
<head>
<meta charset="UTF-8">
<title>자유게시판</title>


<link href="<%=request.getContextPath() %>/resources/summernote/summernote.css" rel="stylesheet">


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
		color: darkgray;
		font-weight: bold;
		font-size: 12pt;
		cursor: pointer;
	}
	.infoStyle {
		color: #034F84;
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
		
		$(".infoDetail").bind("mouseover", function(event){
			var $target = $(event.target);
			$target.addClass("infoStyle");
		});
		$(".infoDetail").bind("mouseout", function(event){
			var $target = $(event.target);
			$target.removeClass("infoStyle");
		});

		searchKeep();
	});  // end of $(document).ready() ---------------------------------
	
	function searchKeep(){
		<c:if test="${(colname != 'null' && not empty colname) && (search != 'null' && not empty search)}">
			$("#colname").val("${colname}");
			$("#search").val("${search}");
		</c:if>
	}
	
	// ==================================== *** userid 또는 name 을 클릭했을 경우 사용자정보를 포함한 모달창 띄우기 *** ===================
	function showUserInfo(userid) {
		var form_data = { "userInfo" : userid };
		$.ajax({
			url: "freeUserInfo.mr",
			type: "GET",
			data: form_data,  // url 요청페이지로 보내는 ajax 요청 데이터
			dataType: "JSON", // ajax 요청에 의해 url 요청페이지로 부터 리턴받는 데이터타입. xml, json, html, text 가 있음.
			success: function(data) {				
				var html = "";
				
				var imgPath = data.infoImg;
				html += "<img src='<%= request.getContextPath() %>/resources/images/" + imgPath + "' style='width: 100px; height: 100px;' />" + "<br/>"
					 +  "<span style='font-weight: bold;'>ID : </span>"+ data.infoUserid + "<br/>"
					 +  "<span style='font-weight: bold;'>성명 : </span>"+ data.infoName + "<br/><br/>"
					 +  "<span style='font-weight: bold;'>핸드폰 : </span>" +data.infoHp1 + "-" +data.infoHp2+"-"+data.infoHp3 +"<br/>"
					 +  "<span style='font-weight: bold;'>생년월일 : </span>" +data.infoBirth1 + " / " + data.infoBirth2 + " / " + data.infoBirth3 + "<br/><br/>"
					 +  "<span style='font-weight: bold;'>주소 : </span>" + data.infoAddr1 + " " + data.infoAddr2 + "<br/><br/>"
					 +  "<span style='font-weight: bold;'>이메일 : </span>" + data.infoEmail + "<br/>";
				
				$(".modal-body").html(html);
				$("#myModal").modal();
			}, // end of success: function()----------
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		}); // end of $.ajax()------------------------
	}
	
	// ======================================== *** 글번호와 URL을 받아서 1개 글 정보 보여주기 *** ===========================
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
	<div style="border: 1px solid pink; padding: 10px; margin-left: 10%; width: 90%;">
		<h1>자유게시판</h1>
		<!-- ===================================== *** 글 검색용 폼 생성 *** ================================================== -->
		<div>
			<form name="searchFrm" action="<%= request.getContextPath() %>/freeList.mr" method="get">
				<select name="colname" id="colname" style="height: 26px; vertical-align: middle;">
					<option value="subject">제목</option>
					<option value="content">내용</option>
					<option value="userid">아이디</option>
					<option value="name">성명</option>
				</select>
				<input type="text" name="search" id="search" size="30" style="height: 26px; vertical-align: middle;" />
				<button type="button" onClick="goSearch();" style="vertical-align: middle;">검색</button>
			</form>
		</div>
		<br/>
		<!-- ==================================== *** 자유게시판 목록 *** ============================================ -->
		<div style="width: 100%;">
			<table id="freeboard" style="width: 80%;">
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
					<c:forEach var="freevo" items="${freeList}" varStatus="status">
						<tr>
							<td>${freevo.idx}</td>
							<td>
								<span class="infoDetail" onClick="showUserInfo('${freevo.userid}')">${freevo.userid}</span>
							</td>
							<td>
								<span class="infoDetail" onClick="showUserInfo('${freevo.userid}')">${freevo.name}</span>
							</td>
							
							<!-- 자유게시판 목록에서 제목 클릭시 수행 할 작업 -->
							<td>
								<c:if test="${freevo.commentCnt > 0}">
									<span class="subject" onClick="goView('${freevo.idx}','${gobackURL}')">${freevo.subject}</span>
									<span style="color: red; font-weight: bold; font-style: italic; font-size: smaller; vertical-align: super;">[${freevo.commentCnt}]</span>
								</c:if>
								<c:if test="${freevo.commentCnt == 0}">
									<span class="subject" onClick="goView('${freevo.idx}','${gobackURL}')">${freevo.subject}</span>
								</c:if>
							</td>
							
							<td>${freevo.readCnt}</td>
							<td>${freevo.regDate}</td>
						<tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<br/>
		<div>
			<button type="button" onClick="javascript:location.href='<%= request.getContextPath() %>/freeList.mr'">전체 글목록</button>&nbsp;
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


<!-- 모달 창 -->
<!-- Modal -->
<div class="modal fade" id="myModal" role="dialog">
	<div class="modal-dialog">

		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">회원 상세 정보</h4>
			</div>
			<div class="modal-body">
			<p></p>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
		</div>

	</div>
</div>



