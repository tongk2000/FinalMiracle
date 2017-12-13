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
	
	th {
		width: 20%;
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

</style>

<script type="text/javascript">
	$(document).ready(function(){
		// ==================================================== *** 회원 아이디나 성명 클릭시 상세정보 모달창으로 띄우기 *** ===============
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
	});
	
	// ===================================== *** 댓글 달기 폼 전송하기 *** ====================================================
    function goWrite() {
    	var addWriteFrm = document.addWriteFrm;
    	addWriteFrm.submit();
    }
    
    // ==================================== *** 대댓글 달기 폼 띄우기 *** =====================================================
    function test(idx) {
    	$("#comment"+idx).after("<tr><td colspan='5'>되냐</td></tr>");
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
</script>

<div style="margin-left: 10%; margin-top: 30px; padding: 10px; border: solid 0px red; width: 80%;">
	
	<table id="table" style="width: 70%; border: 1px solid dimgray; border-left: none; border-right: none;">
		<!-- ============================= *** 자유게시판 소개 *** =================================== -->
		<tr class="title above">
			<td colspan="2" style="padding-left: 20px; font-weight: bold;">자유게시판입니다.</td>
		</tr>
		<tr class="title">
		<td colspan="2" style="padding-left: 10px;">
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
			<td colspan="2" style="padding-left: 20px;"> 
				<br/><br/>
				<span onClick="goView('${freevo.idx}', '${gobackURL}')">≪ 이전글 </span> &nbsp;&nbsp;&nbsp;
				<span style="font-weight: bold;">현재 글번호 : </span>${freevo.idx} &nbsp;&nbsp;&nbsp;
				다음글 ≫
				<br/><br/>
			</td>
		</tr>
		<!-- ============================= *** 제목, 게시글 작성자 및 상세정보 *** ========================= -->
		<tr>
           	<th>
				<img src="<%= request.getContextPath() %>/resources/images/${freevo.img}" style="width: 100px; height: 100px;" align="middle">
           	</th>
           	<td style="border: 1px solid lightgray; border-top: none; border-left: none; border-right: none; padding-left: 10px;">
	           	<input type="hidden" name="idx" value="${freevo.idx}" />
	           	<span style="font-weight: bold; font-size: 11pt;">
	           		제목 : ${freevo.subject}
	           	</span>
	           	<br/><br/>
		           	아이디 : <span class="subjectInfo" onClick="showUserInfo('${freevo.userid}')">${freevo.userid}</span> / 
		           	성명 : <span class="subjectInfo" onClick="showUserInfo('${freevo.userid}')">${freevo.name}</span>
		           	<br/>
		           	조회수 : ${freevo.readCnt}
           	</td>
       	</tr>
       	<!-- ============================= *** 내용물 *** ================================ -->
		<tr>
			<td colspan="2" style="padding-left: 20px;">
				<br/><br/>
				<span style="font-size: 11pt;">${freevo.content}</span>
				<br/><br/>
			</td>
		</tr>

		<tr>
			<th style="padding-left: 10px;">게시글 등록일자</th>
			<td style="padding-left: 50px;">${freevo.regDate}</td>
		</tr>
	</table>
	
	<br/>
	<!-- ============================================================ *** 목록 , 게시글 수정 / 삭제 버튼 *** =================================== -->
	<div>
		<button type="button" onClick="javascript:location.href='<%= request.getContextPath() %>/freeList.mr'">목록보기</button>
		<button type="button" onClick="javascript:location.href='<%= request.getContextPath() %>/freeEdit.mr?idx=${freevo.idx}'">수정</button>
		<button type="button" onClick="javascript:location.href='<%= request.getContextPath() %>/freeDel.mr?idx=${freevo.idx}'">삭제</button>
	</div>	
	<br/>
	
	<!-- ======================= *** 댓글쓰기 폼 추가 *** ================================== -->
	<div style="border: 1px solid #006E51; border-left: none; border-right: none; width: 80%; padding: 5px; background-color: #98DDDE">
		<form name="addWriteFrm" action="<%= request.getContextPath() %>/freeComment.mr" method="get">
			<span style="font-weight: bold;">ID : </span>${sessionScope.loginUser.userid}    &nbsp;
			<input type="hidden" name="userid" value="${sessionScope.loginUser.userid}" size="3" readonly />
			
			<span style="font-weight: bold;">성명 : </span>${sessionScope.loginUser.name}
			<input type="hidden" name="name" value="${sessionScope.loginUser.name}" size="3" class="short" readonly />&nbsp;&nbsp;
			
			<span style="font-weight: bold;">댓글 : </span>
			<input type="text" name="content" class="long" size="50" />
			
			<!-- ==================== *** 댓글에 달리는 원게시물 글번호(tblBoard idx) *** =========================== -->
			<input type="hidden" name="parentIdx" value="${freevo.idx}" />
			
			<!-- ==================== *** 돌아갈 글목록 페이지 *** ================================================ -->
			<input type="hidden" name="gobackURL" value="${gobackURL}">
			&nbsp;&nbsp;<button type="button" onClick="goWrite();">댓글작성</button>
		</form>
	</div>
	
	<br/>
	
	<div style = "border: 0px solid pink;">
		<!-- ======================================== *** 댓글 내용 보여주기 *** =================================================== -->
		<c:if test="${not empty freeCommentList}">
			<table id="comment" style="width: 80%; margin-left: 5%; padding: 10px;">
				<c:forEach var="commentvo" items="${freeCommentList}" >
					<tr id="comment${commentvo.idx}">
						<td style="border: 1px dashed #D8AE47; border-left: none; border-right: none; width: 5%;">
							<img src="<%= request.getContextPath() %>/resources/images/${commentvo.img}" style="width: 35px; height: 30px;" align="middle">
						</td>
						<td style="border: 1px dashed #D8AE47; border-left: none; border-right: none; width: 25%; padding-left: 10px; background-color: lightblue">
							<span style="font-weight: bold;">작성자 : </span>
							<span class="repleInfo" onClick="showUserInfo('${commentvo.userid}')">${commentvo.userid} [${commentvo.name}]</span>
						</td>
						<td style="border: 1px dashed #D8AE47; border-left: none; border-right: none; width: 30%; padding-left: 10px;">
							<span style="font-size: 11pt;">${commentvo.content}</span>
						</td>
						<td style="border: 1px dashed #D8AE47; border-left: none; border-right: none; width: 20%; padding-left: 10px;">
							${commentvo.regDate}
						</td>
						<!-- ============================= *** 대댓글 달기 칸 만들기 *** =============================== -->
						<td>
							<input type="button" value="댓글달기" onclick="test(${commentvo.idx})"/>
						</td>
					</tr>
				</c:forEach>
			</table>
		</c:if>
	</div>
	
</div>


<!-- 해당 글 조회용 폼 생성 -->
<form name="idxFrm">
	<input type="hidden" name="idx" />
	<input type="hidden" name="gobackURL" />
</form>



<!-- 회원 상세정보 모달 창 -->
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







