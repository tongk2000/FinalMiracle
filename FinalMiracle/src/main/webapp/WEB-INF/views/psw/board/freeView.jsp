<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
   
<style type="text/css">

	.title {
		border: 1px solid lightgray;
		border-left: none;
		border-right: none;
	}	
	.above {
		background-color: lightblue;
	}
	td {
		font-size: 10pt;
		font-family: verdana;
	}
	
	.infoStyle {
		color: #034F84;
		font-style: italic;
		text-decoration: underline;
		font-size: 10pt;
		cursor: pointer;
	}
	.subjectInfoStyle {
		color: #4F84C4;
		font-style: italic;
		text-decoration: underline;
		font-size: 10pt;
		cursor: pointer;
	}
	
	.freeListRowCssStyle {
		background-color: #F0F0F0;
	}
	
	.freeReplyListRowCssStyle {
		background-color: #F0F0F0;
	}
	
	.hoverStyleCss {
		font-style: italic;
		font-size: 11pt;
		font-weight: bold;
		cursor: pointer;
	}
	
	.hoverBeforeNextStyleCss {
		font-style: italic;
		font-size: 11pt;
		font-weight: bold;
		cursor: pointer;
	}
	
	.subjectStyle {
		color: black;
		font-weight: bold;
		font-size: 10pt;
		cursor: pointer;
	}
	.delMyCommentButtonCss {
		color: red;
		font-weight: bold;
		font-size: 11pt;
	}

</style>

<script type="text/javascript">
	$(document).ready(function(){
		// ==================================================== *** 회원 아이디나 성명에 mouseover out 효과주기 *** ===============
		$(".repleInfo").bind("mouseover", function(event){
			var $target = $(event.target);
			$target.addClass("infoStyle");
		});
		$(".repleInfo").bind("mouseout", function(event){
			var $target = $(event.target);
			$target.removeClass("infoStyle");
		});
		$(".subjectInfo").bind("mouseover", function(event){
			var $target = $(event.target);
			$target.addClass("subjectInfoStyle");
		});
		$(".subjectInfo").bind("mouseout", function(event){
			var $target = $(event.target);
			$target.removeClass("subjectInfoStyle");
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
		// ================================== *** 이전글 다음글 타겟시 hover 효과 주기 *** ============================
		$(".beforeNextStyle").hover(function(){ 
			$(this).addClass("hoverBeforeNextStyleCss");
		},function(){
			$(this).removeClass("hoverBeforeNextStyleCss");
		});
		// ================================== *** 버튼 타겟시 hover 효과 주기 *** ============================
		$(".hoverStyle").hover(function(){ 
			$(this).addClass("hoverStyleCss");
		},function(){
			$(this).removeClass("hoverStyleCss");
		});
		
		// ================================== *** 자유게시판 목록 행 전체에 hover 효과 주기 *** ============================
		$(".freeListRow").hover(function(){ 
			$(this).addClass("freeListRowCssStyle");
		},function(){
			$(this).removeClass("freeListRowCssStyle");
		});
		
		// ================================== *** 댓글 목록 행 전체에 hover 효과 주기 *** ============================
		$(".freeReplyListRow").hover(function(){ 
			$(this).addClass("freeReplyListRowCssStyle");
		},function(){
			$(this).removeClass("freeReplyListRowCssStyle");
		});
		// ================================== *** 내 댓글 삭제 버튼 타겟시 hover 효과 주기 *** ============================
		$(".delMyCommentButton").hover(function(){ 
			$(this).addClass("delMyCommentButtonCss");
		},function(){
			$(this).removeClass("delMyCommentButtonCss");
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
	});  // end of $(document).ready() -------------------------------------------------------------------
	
	// ===================================== *** 댓글 달기 폼 전송하기 *** ====================================================
    function goWrite() {
    	var addWriteFrm = document.addWriteFrm;
    	addWriteFrm.submit();
    }
    
    // ==================================== *** 대댓글 달기 폼 띄우기 *** =====================================================
    function test(idx) {
    	$("#comment"+idx).after("<tr><td colspan='5'><input type='text'/></td></tr>");
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
				html += "<div style='font-family: verdana; font-size: 10pt; border: 2px dotted #E8E8E8; border-radius: 20px; background-color: #F0F0F0; padding: 5px;'><div style='float: right;'><img src='<%= request.getContextPath() %>/resources/files/" + imgPath + "' style='width: 80px; height: 80px; border-radius: 50px;' /></div>" + "<br/>"
					 +  "<span style='font-weight: bold;'>ID : </span>"+ data.infoUserid + "<br/>"
					 +  "<span style='font-weight: bold;'>성명 : </span>"+ data.infoName + "<br/><br/>"
					 +  "<span style='font-weight: bold;'>핸드폰 : </span>" +data.infoHp1 + "-" +data.infoHp2+"-"+data.infoHp3 +"<br/>"
					 +  "<span style='font-weight: bold;'>생년월일 : </span>" +data.infoBirth1 + " / " + data.infoBirth2 + " / " + data.infoBirth3 + "<br/><br/>"
					 +  "<span style='font-weight: bold;'>주소 : </span>" + data.infoAddr1 + " " + data.infoAddr2 + "</span><br/>"
					 +  "<span style='font-weight: bold;'>이메일 : </span>" + "<a href=\"javascript:goEmail('"+data.infoEmail+"');\">" + data.infoEmail + "</a><br/><br/>"
					 +  "<span style='font-weight: bold;'>소개 : </span>" + data.infoProfile +"</div>" ;
				
				$(".modal-body").html(html);
				$("#freeViewModal").modal();
			}, // end of success: function()----------
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		}); // end of $.ajax()------------------------
	}
 	
	function goEmail(email){
		
		window.open("tmWriteEmail.mr?email="+email, "subwinpop", "left=500px, top=500px, width=800px, height=600px");
	}
 	
	// ======================================== *** 글번호와 URL을 받아서 1개 글 정보 보여주기 *** ===========================
	function goView(idx){
		var frm = document.idxFrm;
		frm.idx.value = idx;
		
		frm.method = "get";
		frm.action = "<%= request.getContextPath() %>/freeView.mr";
		frm.submit();
	}
	
	function goDelComment(idx){
		var frm = document.commentFrm;
		frm.commentIdx.value = idx;
		
		frm.method = "get";
		frm.action = "<%= request.getContextPath() %>/freeCommentDel.mr";
		frm.submit();
	}
	
</script>


<div style="height: 100%; border: 0px dotted pin; overflow-y: scroll;" align="center" >
	<div style="border: solid 0px red; width: 800px; margin-top: 20px; margin-bottom: 20px;" >
		<div style="float: left;">
			<table id="table" style="width: 550px; border: 0px solid dimgray; border-left: none; border-right: none;">
				<!-- ============================= *** 자유게시판 소개 *** =================================== -->
				<tr class="title above">
					<td colspan="2" style="padding-left: 20px; font-weight: bold; font-size: 10pt;">
						<span style="vertical-align: baseline; color: blue; font-size: smaller;">[${fk_team_idx}팀]</span> 자유게시판입니다.
					</td>
				</tr>
				<tr class="title">
					<td colspan="2" style="padding-left: 10px; font-size: 10pt;">
						미풍양속을 해치지 않는 범위 내에서 자유롭게 작성해주세요.<br/>
						단, 팀원간 마찰은 <a href="<%= request.getContextPath() %>/mindList.mr">마음의 소리 게시판</a>을,
						        팀내 공지사항은 <a href="<%= request.getContextPath() %>/noticeList.mr">공지사항</a> 게시판을,
						<br/>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1:1 대화를 원하시는 회원님은 <a href="<%= request.getContextPath() %>/mindList.mr">쪽지</a> 또는 
						<a href="<%= request.getContextPath() %>/chatting.mr">채팅</a> 기능을 이용해주시기 바랍니다.
					</td>
				</tr>
				<!-- ============================= *** 공 백 *** ================================ -->
				<tr style="border: 1px solid lightgray; border-top: none; border-left: none; border-right: none; border-bottom: none;">
					<td colspan="2" style="padding-left: 10px;"> 
						<br/>
						<c:if test="${freevo.pre_idx ne -9}">
							<span class="beforeNextStyle" style="font-size: 9pt; color: #578CA9; cursor: pointer;" onClick="javascript:location.href='<%= request.getContextPath() %>/freeView.mr?idx=${freevo.pre_idx}&currentShowPageNo=${currentShowPageNo}&sizePerPage=${sizePerPage}&colname=${colname}&search=${search}'">≪ 이전글 </span> &nbsp;&nbsp;&nbsp;
						</c:if>
						<c:if test="${freevo.pre_idx eq -9}">
						</c:if>
						
						<span style="font-size: 10pt; font-weight: bold;">현재 글번호 : </span>${freevo.idx} &nbsp;&nbsp;&nbsp;
						<c:if test="${freevo.next_idx ne 0}">
							<span class="beforeNextStyle" style="font-size: 9pt; color: #578CA9; cursor: pointer;" onClick="javascript:location.href='<%= request.getContextPath() %>/freeView.mr?idx=${freevo.next_idx}&currentShowPageNo=${currentShowPageNo}&sizePerPage=${sizePerPage}&colname=${colname}&search=${search}'">다음글 ≫</span>
						</c:if>
						<c:if test="${freevo.next_idx eq 0}">	
						</c:if>
									
						<br/>
					</td>
				</tr>
			</table >
		</div>
		<!-- ============================= *** 제목, 게시글 작성자 및 상세정보 *** ========================= -->
		<div>
			<table style="width: 800px; border: 1px solid darkgray; border-left: none; border-right: none;">
				<tr>
		           	<th style="width: 8%; padding-top: 5px;">
						<img src="<%= request.getContextPath() %>/resources/files/${freevo.img}" alt="프로필사진" style="width: 90px; height: 90px;" align="middle">
		           	</th>
		           	<td style="border: 1px solid lightgray; border-top: none; border-left: none; border-right: none; padding-left: 20px; padding-top: 10px; padding-bottom: 10px; width: 60%;">
			           	<input type="hidden" name="idx" value="${freevo.idx}" />
			           	<span style="font-weight: bold; font-size: 11pt;">
			           		제목 : ${freevo.subject}
			           	</span>
			           	<br/><br/>
			           	<span style="font-size: 10pt;">
				           	아이디 : <span class="subjectInfo" onClick="showUserInfo('${freevo.userid}')">${freevo.userid}</span> / 
				           	성명 : <span class="subjectInfo" onClick="showUserInfo('${freevo.userid}')">${freevo.name}</span><br/>
				           	조회수 : ${freevo.readCnt}<br/>
				           	등록일자 : ${freevo.regDate}<br/>
				        </span>
		           	</td>
		       	</tr>
		       	<!-- ============================= *** 내용물 *** ================================ -->
				<tr style="min-height: 300px;">
					<td colspan="2" style="padding-left: 20px; padding-bottom: 15px;">
						<br/>
						<span style="font-size: 10pt; font-family: 옛한글;">${freevo.content}</span>
						<br/>
						<input type="hidden" name="groupno" value="${freevo.groupno}" />
						<input type="hidden" name="depthno" value="${freevo.depthno}" />
					</td>
				</tr>
			
			</table>
		</div>
		
		<!-- ============================================================ *** 목록보기 / 답변글쓰기, 게시글 수정 / 삭제 버튼 *** =================================== -->
		<div style="float: left; margin-left: 10px;">
			<a class="hoverStyle" style="font-size: 9pt; text-decoration: none; color: black; cursor: pointer;" href="javascript:location.href='<%= request.getContextPath() %>/freeList.mr?currentShowPageNo=${currentShowPageNo}&sizePerPage=${sizePerPage}&colname=${colname}&search=${search}'">목록보기</a>
			&nbsp;&nbsp;&nbsp;
			<a class="hoverStyle" style="font-size: 9pt; text-decoration: none; color: black; cursor: pointer;" href="javascript:location.href='<%= request.getContextPath() %>/freeAdd.mr?fk_idx=${freevo.idx}&groupno=${freevo.groupno}&depthno=${freevo.depthno}'">답변글쓰기</a>
		</div>
		<div style="float: right; margin-right: 20px;">
			<a class="hoverStyle" style="font-size: 9pt; text-decoration: none; color: black; cursor: pointer;" href="javascript:location.href='<%= request.getContextPath() %>/freeEdit.mr?idx=${freevo.idx}'">글수정</a> &nbsp;&nbsp;&nbsp;
			<a class="hoverStyle" style="font-size: 9pt; text-decoration: none; color: black; cursor: pointer;" href="javascript:location.href='<%= request.getContextPath() %>/freeDel.mr?idx=${freevo.idx}&userid=${freevo.userid}'">글삭제</a>
		</div><br/><br/>
		
		
		<!-- ======================= *** 댓글쓰기 폼 추가 *** ================================== -->
		<div style="border: 1px solid lightgray; border-left: none; border-right: none; width: 700px; padding: 2px; background-color: lightblue;" align="center">
			<form name="addWriteFrm" action="<%= request.getContextPath() %>/freeComment.mr" method="get">
				<span style="font-family: verdana; ">
					<span style="font-weight: bold; font-size: 9pt;">작성자 : </span>${sessionScope.loginUser.userid} [${sessionScope.loginUser.name}]
				</span>&nbsp;
				<input type="hidden" name="userid" value="${sessionScope.loginUser.userid}" size="3" readonly />
				<input type="hidden" name="name" value="${sessionScope.loginUser.name}" size="3" class="short" readonly />&nbsp;&nbsp;
				
				<span style="font-family: Georgia; font-weight: bold; font-size: 9pt;">댓글 : </span>
				<input type="text" name="content" class="long" size="40" />
				
				<!-- ==================== *** 댓글에 달리는 원게시물 글번호(tblBoard idx) *** =========================== -->
				<input type="hidden" name="parentIdx" value="${freevo.idx}" />
				<input type="hidden" name="currentShowPageNo" value="${currentShowPageNo}"/>
				<input type="hidden" name="sizePerPage" value="${sizePerPage}"/>
				<input type="hidden" name="colname" value="${colname}"/>
				<input type="hidden" name="search" value="${search}"/>
							
				<a class="replyWriteButtonATag hoverStyle" onClick="goWrite();" style="font-size: 9pt; text-decoration: none; color: black; cursor: pointer;">댓글</a>
			</form>
		</div>
		
		<div style = "border: 0px solid pink; margin-top: 3px;">
		
			<!-- ======================================== *** 댓글 내용 보여주기 *** =================================================== -->
			<form name="commentFrm">	
				<c:if test="${not empty freeCommentList}">
					<input type="hidden" name="commentIdx"/>
					<input type="hidden" name="idx" value="${freevo.idx}" />
					<input type="hidden" name="currentShowPageNo" value="${currentShowPageNo}" />
					<input type="hidden" name="sizePerPage" value="${sizePerPage}" />
					<input type="hidden" name="colname" value="${colname}" />
					<input type="hidden" name="search" value="${search}" />
					
					<table id="comment" style="width: 700px; padding: 2px; margin-bottom: 5px;">
						
						<c:forEach var="commentvo" items="${freeCommentList}" varStatus="status" >
							<tr class="freeReplyListRow">
								<td style="border: 1px solid lightgray; border-left: none; border-right: none; width: 2%; padding-left: 10px;">
									<span style="font-weight: bold; font-size: smaller;"> ${status.count}</span>
								</td>
								<td style="border: 1px solid lightgray; border-left: none; border-right: none; width: 2%;">
									<img src="<%= request.getContextPath() %>/resources/files/${commentvo.img}" style="width: 28px; height: 30px; border-radius: 15px; vertical-align: middle; padding-top: 2px; padding-bottom: 2px;" align="middle">
								</td>
								<td style="border: 1px solid lightgray; border-left: none; border-right: none; width: 12%; padding-left: 10px;">
									<span class="repleInfo" onClick="showUserInfo('${commentvo.userid}')" style="font-size: 9pt;">
										${commentvo.userid} [${commentvo.name}]
										<input type="hidden" name="userid" value="${commentvo.userid}" />
									</span>
								</td>
								<td style="border: 1px solid lightgray; border-left: none; border-right: none; width: 30%; padding-left: 10px;">
									<span style="font-size: 9pt;">${commentvo.content}</span>
								</td>
								<td style="border: 1px solid lightgray; border-left: none; border-right: none; width: 20%; padding-left: 10px;">
									<span style="font-size: 9pt;">${commentvo.regDate}</span>
								</td>
								<td style="border: 1px solid lightgray; border-left: none; border-right: none; width: 2%; margin-right: 10px;">
									<c:if test="${sessionScope.loginUser.userid eq commentvo.userid}">
										<span class="delMyCommentButton" style="cursor: pointer;" onClick="goDelComment('${commentvo.idx}');">x</span>
									</c:if>
									<c:if test="${sessionScope.loginUser.userid ne commentvo.userid}">
										
									</c:if>
								</td>
							</tr>
						</c:forEach>
					</table>
				</c:if>
			</form>
		</div>
		
	</div>


	<!-- ==================================== *** 자유게시판 목록 *** ============================================ -->
	<div style="border: 0px solid blue; width: 800px; padding-top: 10px; margin-bottom: 5%;">
		<div align="left" style="margin-left: 20px;">
			<c:if test="${search == 'null' || search == null || search == ' '}">
				<span style="font-family: verdana; font-weight: bold;">총 게시물 ' 
					<span style="color: #92a8d1; font-size: larger;">${totalCount}</span> ' 개
				</span>
			</c:if> 
			<c:if test="${search != 'null' && search != null && search != ' '}">
				<span style="font-family: verdana; font-weight: bold;">검색된 게시물 ' 
					<span style="color: #92a8d1; font-size: larger;">${totalCount}</span> ' 개
				</span>
			</c:if> 
		</div>
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
				<c:forEach var="fvo" items="${freeList}" varStatus="status">
					<c:if test="${freevo.idx == fvo.idx}">
						<tr class="freeListRow" style="background-color: #E0E0E0; color: #034F84; font-family: verdana; font-weight: bold;">
					</c:if>
					<c:if test="${freevo.idx != fvo.idx}">
						<tr class="freeListRow">
					</c:if>
						<td style="border: 1px solid lightgray; border-left: none; border-right: none; text-align: center;">
							${fvo.idx}
						</td>
						<td  style="border: 1px solid lightgray; border-left: none; border-right: none; margin-left: 30px;">
							<span class="infoDetail" onClick="showUserInfo('${fvo.userid}')">
								<span style="font-size: 10pt; font-family: verdana; cursor: pointer; ">${fvo.userid} [${fvo.name}]</span>
							</span>
						</td>
						
						<!-- ======================= *** 자유게시판 목록에서 제목 클릭시 해당 게시글 상세 내용 보여주기 *** ============================ -->
						<td style="border: 1px solid lightgray; border-left: none; border-right: none; padding-left: 10px;">
							<c:if test="${fvo.depthno == 0}">	
								<c:if test="${fvo.commentCnt > 0}">
									<span class="subject" onClick="goView(${fvo.idx})">
										<span style="font-family: Georgia; cursor: pointer;">${fvo.subject}</span>
									</span>
									<span style="color: red; font-weight: bold; font-style: italic; font-size: smaller; vertical-align: super;">
										[${fvo.commentCnt}]
									</span>
								</c:if>
								<c:if test="${fvo.commentCnt == 0}">
									<span class="subject" onClick="goView(${fvo.idx})">
										<span style="font-family: Times; cursor: pointer;">${fvo.subject}</span>
									</span>
								</c:if>
							</c:if>
							<!-- ======================================= *** 답변글이 있는 경우 *** ================================== -->
							<c:if test="${fvo.depthno > 0}">
								<c:if test="${fvo.commentCnt > 0}">
									<span class="subject" onClick="goView(${fvo.idx})" style="cursor: pointer;">
										<span style="color: navy; padding-left: ${fvo.depthno*20}px; font-size: smaller; font-weight: bold;">┗[답변글] </span>${fvo.subject}
									</span>
									<span style="color: red; font-weight: bold; font-style: italic; font-size: smaller; vertical-align: super;">
										[${fvo.commentCnt}]
									</span>
								</c:if>
								<c:if test="${fvo.commentCnt == 0}">
									<span class="subject" onClick="goView(${fvo.idx})" style="cursor: pointer;">
										<span style="color: navy; padding-left: ${fvo.depthno*20}px; font-size: smaller; font-weight: bold;">┗[답변글] </span>${fvo.subject}
									</span>
								</c:if>
							</c:if>
						</td>
						
						<td style="border: 1px solid lightgray; border-left: none; border-right: none; text-align: center;">
							${fvo.readCnt}
						</td>
						<td style="border: 1px solid lightgray; border-left: none; border-right: none; text-align: center;">
							${fvo.regDate}
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		
		<div style="width: 150px; float: left; margin-left: 10px; margin-top: 5px;" align="left">
			<span class="showFreeList hoverStyle" onClick="javascript:location.href='<%= request.getContextPath() %>/freeList.mr'" style="font-size: 10pt; font-family: arial black; color: black; cursor: pointer;">첫목록보기</span>&nbsp;&nbsp;
			<span class="addFree hoverStyle" onClick="javascript:location.href='<%= request.getContextPath() %>/freeAdd.mr'" style="font-size: 10pt; font-family: arial black; text-decoration: none; color: black; cursor: pointer;">글쓰기</span>
		</div>
		<!-- ===================================== *** 글 검색용 폼 생성 *** ================================================== -->
		<div style="width: 300px; float: right; margin-top: 5px;">
			<form name="searchFrm" action="<%= request.getContextPath() %>/freeList.mr" method="get">
				<select name="colname" id="colname" style="height: 20px; vertical-align: middle; size:3;">
					<option value="subject">제목</option>
					<option value="content">내용</option>
					<option value="userid">아이디</option>
					<option value="name">성명</option>
				</select>
				
				<input type="text" name="search" id="search" size="20" style="height: 20px; vertical-align: middle;" />
				<a class="searchFreeList hoverStyle" onClick="goSearch();" style="font-size: 10pt; font-family: arial black; text-decoration: none; color: black; cursor: pointer;">검색</a>
			</form>
		</div>	<br/>			
		
		
		<!-- 페이지 바 만들기 -->
		<div style="width: 600px; clear: both; border: 0px solid green;">
			<div align="center">${pagebar}</div>
		</div>
		
	</div>
	
</div>	
	
	

	
	

<!-- ////////////////////////////////////////////////////////////////////////////////////// -->

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
<div class="modal fade modal-center" id="freeViewModal" role="dialog">
	<div class="modal-dialog modal-sm modal-center">
		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">회원 상세 정보</h4>
			</div>
			<div class="modal-body">
			
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
		</div>

	</div>
</div>









