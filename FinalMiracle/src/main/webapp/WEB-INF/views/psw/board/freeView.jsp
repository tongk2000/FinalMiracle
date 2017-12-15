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
	
	.infoStyle {
		color: #034F84;
		font-style: italic;
		text-decoration: underline;
		font-size: 11pt;
		cursor: pointer;
	}
	.subjectInfoStyle {
		color: #4F84C4;
		font-style: italic;
		text-decoration: underline;
		font-size: 11pt;
		cursor: pointer;
	}
	
	.freeListRowCssStyle {
		background-color: lightgray;
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
	
		$(".freeListCss").bind("mouseover", function(event){
			var $target = $(event.target);
			$target.addClass(".freeListCssStyle");
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
	});
	
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
				html += "<div style='float: right;'><img src='<%= request.getContextPath() %>/resources/images/" + imgPath + "' style='width: 100px; height: 100px;' /></div>" + "<br/>"
					 +  "<span style='font-weight: bold;'>ID : </span>"+ data.infoUserid + "<br/>"
					 +  "<span style='font-weight: bold;'>성명 : </span>"+ data.infoName + "<br/>"
					 +  "<span style='font-weight: bold;'>핸드폰 : </span>" +data.infoHp1 + "-" +data.infoHp2+"-"+data.infoHp3 +"<br/>"
					 +  "<span style='font-weight: bold;'>생년월일 : </span>" +data.infoBirth1 + " / " + data.infoBirth2 + " / " + data.infoBirth3 + "<br/>"
					 +  "<span style='font-weight: bold;'>주소 : </span>" + data.infoAddr1 + " " + data.infoAddr2 + "</span><br/>"
					 +  "<span style='font-weight: bold;'>이메일 : </span>" + data.infoEmail + "<br/><br/>"
					 +  "<span style='font-weight: bold;'>소개 : </span>" + data.infoProfile ;
				
				$(".modal-body").html(html);
				$("#freeViewModal").modal();
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
	
</script>


<div style="height: auto; border: 3px dotted pink;" align="center">
	<div style="border: solid 1px red; width: 650px;" >
		<div style="float: left;">
			<table id="table" style="width: 500px; border: 1px solid dimgray; border-left: none; border-right: none;">
				<!-- ============================= *** 자유게시판 소개 *** =================================== -->
				<tr class="title above">
					<td colspan="2" style="padding-left: 20px; font-weight: bold; font-size: 10pt;">자유게시판입니다.</td>
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
				<tr style="border: 1px solid lightgray; border-top: none; border-left: none; border-right: none;">
					<td colspan="2" style="padding-left: 10px;"> 
						<br/>
						<span style="font-size: 9pt; color: #578CA9;" onClick="">≪ 이전글 </span> &nbsp;&nbsp;&nbsp;
						<span style="font-size: 10pt; font-weight: bold;">현재 글번호 : </span>${freevo.idx} &nbsp;&nbsp;&nbsp;
						<span style="font-size: 9pt; color: #578CA9;">다음글 ≫</span>
						<br/>
					</td>
				</tr>
			</table >
		</div>
		<!-- ============================= *** 제목, 게시글 작성자 및 상세정보 *** ========================= -->
		<div>
			<table style="width: 650px; border: 1px solid darkgray; border-left: none; border-right: none;">
				<tr>
		           	<th style="width: 8%; padding-top: 5px;">
						<img src="<%= request.getContextPath() %>/resources/images/${freevo.img}" style="width: 90px; height: 90px;" align="middle">
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
					</td>
				</tr>
			
			</table>
		</div>
		
		<!-- ============================================================ *** 목록 , 게시글 수정 / 삭제 버튼 *** =================================== -->
		<div style="float: left; margin-left: 10px;">
			<a style="font-size: 9pt; text-decoration: none; color: black; cursor: pointer;" href="javascript:location.href='<%= request.getContextPath() %>/freeList.mr?currentShowPageNo=${currentShowPageNo}&sizePerPage=${sizePerPage}&colname=${colname}&search=${search}'">목록보기</a>
		</div>
		<div style="float: right; margin-right: 20px;">
			<a style="font-size: 9pt; text-decoration: none; color: black; cursor: pointer;" href="javascript:location.href='<%= request.getContextPath() %>/freeEdit.mr?idx=${freevo.idx}'">글수정</a> &nbsp;&nbsp;&nbsp;
			<a style="font-size: 9pt; text-decoration: none; color: black; cursor: pointer;" href="javascript:location.href='<%= request.getContextPath() %>/freeDel.mr?idx=${freevo.idx}&userid=${freevo.userid}'">글삭제</a>
		</div><br/><br/>
		
		
		<!-- ======================= *** 댓글쓰기 폼 추가 *** ================================== -->
		<div style="border: 1px solid lightgray; border-left: none; border-right: none; width: 600px; padding: 2px; background-color: lightblue;" align="center">
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
				
				<a class="replyWriteButtonATag" onClick="goWrite();" style="font-size: 9pt; text-decoration: none; color: black; cursor: pointer;">댓글</a>
			</form>
		</div>
		
		<div style = "border: 0px solid pink; margin-top: 3px;">
			<!-- ======================================== *** 댓글 내용 보여주기 *** =================================================== -->
			<c:if test="${not empty freeCommentList}">
				<table id="comment" style="width: 600px; padding: 2px; margin-bottom: 5px;">
					<c:forEach var="commentvo" items="${freeCommentList}" >
						<tr id="comment${commentvo.idx}">
							<td style="border: 0px solid lightgray; border-left: none; border-right: none; width: 3%;">
								<img src="<%= request.getContextPath() %>/resources/images/${commentvo.img}" style="width: 30px; height: 25px; vertical-align: middle; padding-top: 2px; padding-bottom: 2px;" align="middle">
							</td>
							<td style="border: 1px solid lightgray; border-left: none; border-right: none; width: 12%; padding-left: 10px;">
								<span class="repleInfo" onClick="showUserInfo('${commentvo.userid}')" style="font-size: 9pt;">
									${commentvo.userid} [${commentvo.name}]
								</span>
							</td>
							<td style="border: 1px solid lightgray; border-left: none; border-right: none; width: 30%; padding-left: 10px;">
								<span style="font-size: 9pt;">${commentvo.content}</span>
							</td>
							<td style="border: 1px solid lightgray; border-left: none; border-right: none; width: 20%; padding-left: 10px;">
								<span style="font-size: 9pt;">${commentvo.regDate}</span>
							</td>
						</tr>
					</c:forEach>
				</table>
			</c:if>
		</div>
		
	</div>


	<!-- ==================================== *** 자유게시판 목록 *** ============================================ -->
	<div style="border: 1px solid blue; width: 650px; padding-top: 10px;">
		<table style="width: 650px; border: 1px solid dimgray; border-left: none; border-right: none;">
			<thead>
				<tr>
					<th style="text-align: center;">글번호</th>
					<th style="text-align: center;">작성자</th>
					<th style="text-align: center;">글제목</th>
					<th style="text-align: center;">조회수</th>
					<th style="text-align: center;">등록일자</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="freevo" items="${freeList}" varStatus="status">
					<tr class="freeListRow">
						<td style="border: 1px solid lightgray; border-left: none; border-right: none; text-align: center;">
							${freevo.idx}
						</td>
						<td  style="border: 1px solid lightgray; border-left: none; border-right: none; text-align: center;">
							<span class="infoDetail" onClick="showUserInfo('${freevo.userid}')">
								<span style="font-size: 11pt; font-family: verdana; cursor: pointer; ">${freevo.userid} [${freevo.name}]</span>
							</span>
						</td>
						
						<!-- ======================= *** 자유게시판 목록에서 제목 클릭시 해당 게시글 상세 내용 보여주기 *** ============================ -->
						<td style="border: 1px solid lightgray; border-left: none; border-right: none; padding-left: 10px;">
							<c:if test="${freevo.commentCnt > 0}">
								<span class="subject" onClick="goView(${freevo.idx})">
									<span style="font-family: Georgia; cursor: pointer;">${freevo.subject}</span>
								</span>
								<span style="color: red; font-weight: bold; font-style: italic; font-size: smaller; vertical-align: super;">
									[${freevo.commentCnt}]
								</span>
							</c:if>
							<c:if test="${freevo.commentCnt == 0}">
								<span class="subject" onClick="goView(${freevo.idx})">
									<span style="font-family: Georgia; cursor: pointer;">${freevo.subject}</span>
								</span>
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
		
		<div style="width: 150px; float: left; margin-left: 10px;" align="left">
			<span class="showFreeList" onClick="javascript:location.href='<%= request.getContextPath() %>/freeList.mr'" style="font-size: 10pt; font-family: arial black; color: black; cursor: pointer;">첫목록보기</span>&nbsp;
			<span class="addFree" onClick="javascript:location.href='<%= request.getContextPath() %>/freeAdd.mr'" style="font-size: 10pt; font-family: arial black; text-decoration: none; color: black; cursor: pointer;">글쓰기</span>
		</div>
		<!-- ===================================== *** 글 검색용 폼 생성 *** ================================================== -->
		<div style="width: 300px; float: right;">
			<form name="searchFrm" action="<%= request.getContextPath() %>/freeList.mr" method="get">
				<select name="colname" id="colname" style="height: 20px; vertical-align: middle; size:3;">
					<option value="subject">제목</option>
					<option value="content">내용</option>
					<option value="userid">아이디</option>
					<option value="name">성명</option>
				</select>
				
				<input type="text" name="search" id="search" size="20" style="height: 20px; vertical-align: middle;" />
				<a class="searchFreeList" onClick="goSearch();" style="font-size: 10pt; font-family: arial black; text-decoration: none; color: black; cursor: pointer;">검색</a>
			</form>
		</div>	<br/>			
		
		
		<!-- 페이지 바 만들기 -->
		<div style="width: 600px; clear: both; border: 0px solid green;">
			<div align="left">${pagebar}</div>
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









