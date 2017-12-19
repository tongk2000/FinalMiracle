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
	td {
		font-size: 10pt;
		font-family: verdana;
	}
	
	.modal.modal-center {
	  text-align: center;
	}
	@media screen and (min-width: 400px) { 
	  .modal.modal-center:before {
	    display: inline-block;
	    vertical-align: middle;
	    content: " ";
	    height: 100%;
	  }
	}
	.modal-dialog.modal-center {
	  display: inline-block;
	  text-align: left;
	  vertical-align: middle; 
	}	
	
	.subjectStyle {
		color: black;
		font-weight: bold;
		font-size: 10pt;
		cursor: pointer;
	}
	.infoStyle {
		color: #034F84;
		font-weight: bold;
		font-size: 10pt;
		cursor: pointer;
	}
	.addStyle {
		color: #034F84;
		font-weight: bold;
		font-style: italic;
		font-size: 11pt;
		cursor: pointer;
	}
	.searchListStyle {
		color: #034F84;
		font-weight: bold;
		font-style: italic;
		font-size: 11pt;
		text-decoration: underline;
		cursor: pointer;
	}
	
	.freeListRowCssStyle {
		background-color: lightgray;
	}
	
</style>

<script type="text/javascript">
	$(document).ready(function(){
		// ===================================== *** summernote text area 편집기 불러오기 *** ==================================
		$('.summernote').summernote({
		      height: 300,          // 기본 높이값
		      minHeight: null,      // 최소 높이값(null은 제한 없음)
		      maxHeight: null,      // 최대 높이값(null은 제한 없음)
		      lang: 'ko-KR'         // 한국어 지정(기본값은 en-US)
	    });
		// =========================================== *** 글목록에서 제목에 마우스 가져댈 경우 css 효과 주기 *** ===================
 
		$(".subject").bind("mouseover", function(event){
			var $target = $(event.target);
			$target.addClass("subjectStyle");
		});
		$(".subject").bind("mouseout", function(event){
			var $target = $(event.target);
			$target.removeClass("subjectStyle");
		});
		
		
		// =========================================== *** 목록보기 에 마우스 가져댈 경우 css 효과 주기 *** ===================
		$(".showFreeList").bind("mouseover", function(event){
			var $target = $(event.target);
			$target.addClass("subjectStyle");
		});
		$(".showFreeList").bind("mouseout", function(event){
			var $target = $(event.target);
			$target.removeClass("subjectStyle");
		});
		
		// =========================================== *** 글쓰기 에 마우스 가져댈 경우 css 효과 주기 *** ===================
		$(".addFree").bind("mouseover", function(event){
			var $target = $(event.target);
			$target.addClass("addStyle");
		});
		$(".addFree").bind("mouseout", function(event){
			var $target = $(event.target);
			$target.removeClass("addStyle");
		});
		
		// =========================================== *** 검색 에 마우스 가져댈 경우 css 효과 주기 *** ===================
		$(".searchFreeList").bind("mouseover", function(event){
			var $target = $(event.target);
			$target.addClass("searchListStyle");
		});
		$(".searchFreeList").bind("mouseout", function(event){
			var $target = $(event.target);
			$target.removeClass("searchListStyle");
		});
		
		// ====================================================== *** 회원 아이디나 성명에 마우스 클릭시 css 효과 *** ===============
		$(".infoDetail").bind("mouseover", function(event){
			var $target = $(event.target);
			$target.addClass("infoStyle");
		});
		$(".infoDetail").bind("mouseout", function(event){
			var $target = $(event.target);
			$target.removeClass("infoStyle");
		});
		
		// ================================== *** 행 전체에 hover 효과 주기 *** ============================
		$(".freeListRow").hover(function(){ 
			$(this).addClass("freeListRowCssStyle");
		},function(){
			$(this).removeClass("freeListRowCssStyle");
		});
		
		// ============================================== *** 페이지 전체에서 esc 키를 누르면 모달창을 닫기 *** =======
		$(document).on("keydown", function(){
			var modalFlag = $('.modal').is(':visible');
			if(event.keyCode == 27 && modalFlag) { 
				$('.modal').modal('hide');
			}
		}); // end of $("#body").keyup(function() --------------------------------------------------------
		
		// ======================== *** 모달창에서 x 나 Close 를 누르면 모달창 닫기 *** ==================================
		$(document).on("click", ".modalClose", function(){
			$('.modal').modal('hide');
		}); // end of $(".modalClose").click(function() --------------------------------------------------
				
		
		
		// ================== *** 자유게시판에서 검색기능 이용했을 시 검색어 유지시키기 *** ================
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
				html += "<div style='float: right;'><img src='<%= request.getContextPath() %>/resources/images/" + imgPath + "' style='width: 100px; height: 100px; border-radius: 50px;' /></div>" + "<br/>"
					 +  "<span style='font-weight: bold;'>ID : </span>"+ data.infoUserid + "<br/>"
					 +  "<span style='font-weight: bold;'>성명 : </span>"+ data.infoName + "<br/>"
					 +  "<span style='font-weight: bold;'>핸드폰 : </span>" +data.infoHp1 + "-" +data.infoHp2+"-"+data.infoHp3 +"<br/>"
					 +  "<span style='font-weight: bold;'>생년월일 : </span>" +data.infoBirth1 + " / " + data.infoBirth2 + " / " + data.infoBirth3 + "<br/>"
					 +  "<span style='font-weight: bold;'>주소 : </span>" + data.infoAddr1 + " " + data.infoAddr2 + "</span><br/>"
					 +  "<span style='font-weight: bold;'>이메일 : </span>" + data.infoEmail + "<br/><br/>"
					 +  "<span style='font-weight: bold;'>소개 : </span>" + data.infoProfile ;
				
				$(".modal-body").html(html);
				$("#freeListModal").modal();
			}, // end of success: function()----------
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		}); // end of $.ajax()------------------------
	}
	
	// ======================================== *** 글번호와 URL을 받아서 1개 글 정보 보여주기 *** ===========================
	function goView(idx){
		var frm = document.idxFrm;
		frm.idx.value = idx;
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

<div style="border: 0px dotted pink; margin-top: 30px;" align="center">
	<div style="border: 0px solid orange; width: 800px;" align="left">
		<!-- ============================= *** 자유게시판 소개 *** =================================== -->
		<div style="width: 600px;">
			<table>
				<tr class="title above">
					<td colspan="2" style="padding-left: 20px; font-weight: bold; background-color: lightblue;">
						<span style="font-size: smaller; vertical-align: baseline; color: blue;">[${fk_team_idx} 팀] </span>자유게시판입니다.
					</td>
				</tr>
				<tr class="title">
					<td colspan="2" style="padding-left: 10px; border: 1px solid lightgray; border-left: none; border-right: none;">
						미풍양속을 해치지 않는 범위 내에서 자유롭게 작성해주세요.<br/>
						단, 팀원간 마찰은 <a href="<%= request.getContextPath() %>/mindList.mr">마음의 소리 게시판</a>을,
						       팀내 공지사항은 <a href="<%= request.getContextPath() %>/noticeList.mr">공지사항</a> 게시판을,
						<br/>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1:1 대화를 원하시는 회원님은 <a href="<%= request.getContextPath() %>/mindList.mr">쪽지</a> 또는 
						<a href="<%= request.getContextPath() %>/chatting.mr">채팅</a> 기능을 이용해주시기 바랍니다.
					</td>
				</tr>
				<!-- ============================= *** 공 백 *** ================================ -->
				<tr style="border: 0px solid lightgray;">
					<td colspan="2" style="padding-left: 20px;"> 
						<br/>
						<c:if test="${search eq null || empty search}">
							<span style="font-weight: bold;">총 게시글 '<span style="font-size: larger; color: orange;"> ${totalCount} </span>' 개</span>
						</c:if>
						<c:if test="${search ne null && not empty search}">
							<span style="font-weight: bold;">검색된 게시글 '<span style="font-size: larger; color: orange;"> ${totalCount} </span>' 개</span>
						</c:if>
					</td>
				</tr>
			</table>
		</div>
		<!-- ==================================== *** 자유게시판 목록 *** ============================================ -->
		<div style="width: 800px;">
			<table style="width: 800px; border: 1px solid dimgray; border-left: none; border-right: none;">
				<thead>
					<tr style="background-color: silver;">
						<th style="text-align: center; padding: 2px;">글번호</th>
						<th style="text-align: center; padding: 2px;">작성자</th>
						<th style="text-align: center; padding: 2px;">글제목</th>
						<th style="text-align: center; padding: 2px;">조회수</th>
						<th style="text-align: center; padding: 2px;">등록일자</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="freevo" items="${freeList}" varStatus="status">
						<tr class="freeListRow">
							<td style="border: 1px solid lightgray; border-left: none; border-right: none; text-align: center;">
								${freevo.idx}
							</td>
							<td  style="border: 1px solid lightgray; border-left: none; border-right: none; margin-left: 20px;">
								<span class="infoDetail" onClick="showUserInfo('${freevo.userid}')">
									<span style="cursor: pointer;">${freevo.userid} [${freevo.name}]</span>
								</span>
							</td>
							
							<!-- ======================= *** 자유게시판 목록에서 제목 클릭시 해당 게시글 상세 내용 보여주기 *** ============================ -->
							<td style="border: 1px solid lightgray; border-left: none; border-right: none; padding-left: 10px;">
							<!-- ======================================= *** 답변글이 없는 경우 *** ================================= -->
							<c:if test="${freevo.depthno == 0}">	
								<c:if test="${freevo.commentCnt > 0}">
									<span class="subject" onClick="goView(${freevo.idx})">
										<span style="font-family: Georgia;">${freevo.subject}</span>
									</span>
									<span style="color: red; font-weight: bold; font-style: italic; font-size: smaller; vertical-align: super;">
										[${freevo.commentCnt}]
									</span>
								</c:if>
								<c:if test="${freevo.commentCnt == 0}">
									<span class="subject" onClick="goView(${freevo.idx})">
										<span style="font-family: Times;">${freevo.subject}</span>
									</span>
								</c:if>
							</c:if>
							<!-- ======================================= *** 답변글이 있는 경우 *** ================================== -->
							<c:if test="${freevo.depthno > 0}">
								<c:if test="${freevo.commentCnt > 0}">
									<span class="subject" onClick="goView(${freevo.idx})">
										<span style="color: navy; padding-left: ${freevo.depthno*20}px; font-size: smaller; font-weight: bold;">┗[답변글] </span>${freevo.subject}
									</span>
									<span style="color: red; font-weight: bold; font-style: italic; font-size: smaller; vertical-align: super;">
										[${freevo.commentCnt}]
									</span>
								</c:if>
								<c:if test="${freevo.commentCnt == 0}">
									<span class="subject" onClick="goView(${freevo.idx})">
										<span style="color: navy; padding-left: ${freevo.depthno*20}px; font-size: smaller; font-weight: bold;">┗[답변글] </span>${freevo.subject}
									</span>
								</c:if>
							</c:if>
							</td>
							
							<td style="border: 1px solid lightgray; border-left: none; border-right: none; text-align: center;">
								${freevo.readCnt}
							</td>
							<td style="border: 1px solid lightgray; border-left: none; border-right: none; text-align: center;">
								${freevo.regDate}
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		
		<div style="float: left; margin-left: 10px; margin-top: 5px;">
			<span class="showFreeList" onClick="javascript:location.href='<%= request.getContextPath() %>/freeList.mr'" style="font-size: 10pt; font-family: arial black; color: black; cursor: pointer;">첫목록보기</span>&nbsp;
			<span class="addFree" onClick="javascript:location.href='<%= request.getContextPath() %>/freeAdd.mr'" style="font-size: 10pt; font-family: arial black; text-decoration: none; color: black; cursor: pointer;">글쓰기</span>
		</div>
		
		<!-- ===================================== *** 글 검색용 폼 생성 *** ================================================== -->
		<div style="float: right; margin-right: 10px; margin-top: 5px;">
			<form name="searchFrm" action="<%= request.getContextPath() %>/freeList.mr" method="get">
				<select name="colname" id="colname" style="height: 20px; vertical-align: middle; box-sizing: border-box; ">
					<option value="subject">제목</option>
					<option value="content">내용</option>
					<option value="userid">아이디</option>
					<option value="name">성명</option>
				</select>
				
				<input type="text" name="search" id="search" size="30" style="height: 20px; vertical-align: middle;" />
				<a class="searchFreeList" onClick="goSearch();" style="font-size: 10pt; font-family: arial black; text-decoration: none; color: black; cursor: pointer;">검색</a>
			</form>
		</div>
		<!-- 페이지 바 만들기 -->
		<div style="width: 800px; clear: both;">
			${pagebar}
		</div>
	</div>
	
	
</div>	
	
	
	
</body>


</html>

<!-- 해당 글 조회용 폼 생성 -->
<form name="idxFrm">
	<input type="hidden" name="idx"/>
	<input type="hidden" name="currentShowPageNo" value="${currentShowPageNo}"/>
	<input type="hidden" name="sizePerPage" value="${sizePerPage}"/>
	<input type="hidden" name="colname" value="${colname}"/>
	<input type="hidden" name="search" value="${search}"/>
	
</form>


<!-- 회원 상세정보 모달 창 -->
<!-- Modal -->
<div class="modal fade modal-center" id="freeListModal" role="dialog">
	<div class="modal-dialog modal-sm modal-center">
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



















