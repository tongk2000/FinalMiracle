<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.net.InetAddress"%>

<%-- ===== tiles 중 header 페이지 만들기  ===== --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style type="text/css">
	
	.modal.modal-center {
	  text-align: center;
	}
	
	@media screen and (min-width: 768px) { 
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
	
	div .searchAllLine {
		background-color:white !important;
		color:#154465;
	}
	#searchAllResult div {
		padding-left:10px;
		padding-right:10px;
		border-radius:10px;
	}

</style>

<script type="text/javascript">
	function showMyInfo() {
		$.ajax({
			url: "member_edit.mr",
			type: "GET",
			dataType: "HTML", // ajax 요청에 의해 url 요청페이지로 부터 리턴받는 데이터타입. xml, json, html, text 가 있음.
			success: function(data) {	
				$("#modalBody").html(data);
				$("#memberEditModal").modal();
			}, error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});
	} // end of function showMyInfo() ------------------------------------------------------------------------------------------------------
	
	// ------------------------------------------------------ ***** 통합 검색 관련 함수 시작 ***** ------------------------------------------------------
	$(document).ready(function(){
		$("#searchWordByAll").keydown(function(e){
			var key = e.keyCode;
			var $show = $("#searchAllResult").find("div:visible");
			var $first = $("#searchAllResult").find("div:visible:first");
			var $last = $("#searchAllResult").find("div:visible:last");
			if(key == 17) {
				isCtrl = true;
			}
			
			if(key == 38) { // up key
				if( $first.hasClass("searchAllLine") ) {
					return false;
				} else {
					if( $show.hasClass("searchAllLine") ) {
						$(".searchAllLine").removeClass("searchAllLine").prevAll(":visible:first").addClass("searchAllLine");
					} else {
						$last.addClass("searchAllLine");
					}
				}
				var endFocus = $("#searchWordByAll").val();  // 이렇게
				$("#searchWordByAll").val("").val(endFocus); // 짝지어주면 글 커서가 제일 마지막으로 감!!
				
				var lineT = $(".searchAllLine").offset().top;
				var listT = $("#searchAllResult").offset().top;
				var lineH = $(".searchAllLine").offset().top + $(".searchAllLine").height();
				var listH = $("#searchAllResult").offset().top + $("#searchAllResult").height();
				if(lineT < listT || lineH > listH) { // up key 는 맨 아래로 한번에 갈 수 있으므로 조건 하나 더 추가됨
					$(".searchAllLine")[0].scrollIntoView();				
				}
				return false;
			}
			if(key == 40) { // down key
				if( $last.hasClass("searchAllLine") ) {
					return false;
				} else {
					if( $show.hasClass("searchAllLine") ) {
						$(".searchAllLine").removeClass("searchAllLine").nextAll(":visible:first").addClass("searchAllLine");
					} else {
						$first.addClass("searchAllLine");
					}
				}
				var lineH = $(".searchAllLine").offset().top + $(".searchAllLine").height();
				var listH = $("#searchAllResult").offset().top + $("#searchAllResult").height();
				if(lineH > listH) {
					$(".searchAllLine")[0].scrollIntoView(false);					
				}
				return false;
			}

			if(key == 13) { // enter key
				$(".searchAllLine").click();
				return false;
			}
		}); // end of $("#searchWordByAll").keydown(function(e) -------------------------------------------------------------------------
		
		$("#searchWordByAll").keyup(function(e){
			var key = e.keyCode;
			if(key == 38 || key == 40 || key == 13) { // up 혹은 down 혹은 enter 라면 keyup 이벤트는 멈춤 
				return false;
			}
			
			var searchWord = $("#searchWordByAll").val();
			// 검색어가 없다면 결과창 비우고 끝내기
			if(searchWord.trim() == "") {
				$("#searchAllResult").empty();
				return false;
			}
			// 검색어가 있다면 검색결과를 받아와서 뿌려주기
			var frm = {"searchWord":searchWord};
			if(searchWord != "") {
				$.ajax({
					url:"do_getSearchWordByAll.mr",
					data:frm,
					type:"get",
					dataType:"xml",
					success:function(data){
						var html = "<div id='returnAllResult' onclick='returnAllResult()' style='display:none; cursor:pointer;'>"
								  +"&lt;- 전체 검색 결과 보기</div>";
						html += getSearchListByCategory(data, 'projectSize', '프로젝트', 'project', searchWord, 'resultOfProject', 'doList.mr', 'sideDoIcon', 'goSearchToProject');
						html += getSearchListByCategory(data, 'noticeSize', '공지사항', 'notice', searchWord, 'resultOfNotice', 'noticeView.mr', 'sideNoticeIcon', 'goSearchToNotice');
						html += getSearchListByCategory(data, 'mindSize', '마음의소리', 'mind', searchWord, 'resultOfMind', 'mindView.mr', 'sideMindIcon', 'goSearchToMind');
						html += getSearchListByCategory(data, 'freeSize', '자유게시판', 'free', searchWord, 'resultOffree', 'freeView.mr', 'sideFreeIcon', 'goSearchToFree');

						var left = $("#searchWordByAll").offset().left;
						var top = $("#searchWordByAll").offset().top + $("#searchWordByAll").height() + 15;
						$("#searchAllResult").css({"left":left+"px", "top":top+"px"});
						$("#searchAllResult").html(html);
					}, error: function (xhr, ajaxOptions, thrownError) {
				        console.log(xhr.status);
				        console.log(thrownError);
				    }
				});
			}
		}); // end of $("#searchWordByAll").keyup(function() --------------------------------------------------------------------------------
		
		// 줄 선택시 css 입히기 (맥북이라 그런지 hover 는 안먹힘)
		$(document).on("mouseover", "#searchAllResult div", function(){
			$("div").removeClass("searchAllLine");
			$(this).addClass("searchAllLine");
		});
		$(document).on("mouseout", "#searchAllResult div", function(){
			$(this).removeClass("searchAllLine");
		}); // end of 줄 선택시 css 입히기 ----------------------------------
		
	}); // end of $(document).ready(function() ------------------------------------------------------------------------------------------------
	
	// 각 카테고리별 리스트를 동적으로 처리해주기
	function getSearchListByCategory(data, sizeName, sizeNameKor, arrName, searchWord, className, url, icon, functionName) {
		var html = "";
		var sizeName = $(data).find(":root").find(sizeName).text(); // 카테고리별 갯수
		if(parseInt(sizeName) > 5) {
			html += "<div class='allSearchResult firstShowResult' onclick='showCategoryAll(\""+className+"\")' style='cursor:pointer;'>"
			      + sizeNameKor+" 검색결과 : "+sizeName+"개 모두 보기</div>";
		} else {
			html += "<div class='allSearchResult firstShowResult'>"+sizeNameKor+" 검색결과 : "+sizeName+"개</div>";
		}
		
		var searchArr = $(data).find(":root").find(arrName); // 카테고리별 배열
		var cnt = 0; // 처음엔 5개만 보여주기 위한 변수
		var reg = new RegExp(searchWord.trim(), "gi"); // 검색결과는 색깔을 달리 주기 위한 정규식
		searchArr.each(function(){
			var subject = $(this).find("subject").text().replace(reg, "<span style='color:red;'>"+searchWord.trim()+"</span>");
			var idx = $(this).find("idx").text();
			var category = $(this).find("category").text();
			cnt++;
			if(cnt <= 5) { // 한 카테고리당 우선 5개까지만 보여주고 나머지는 숨김
				html += "<div class='allSearchResult firstShowResult "+className+"' style='margin-left:15px; cursor:pointer;' onclick='"+functionName+"("+idx+", \""+url+"\", \""+icon+"\", \""+category+"\")'>"+subject+"</div>";
			} else {
				html += "<div class='allSearchResult "+className+"' style='margin-left:15px; cursor:pointer; display:none;' onclick='"+functionName+"("+idx+", \""+url+"\", \""+icon+"\", \""+category+"\")'>"+subject+"</div>";
			}
			html += "<input type='hidden' value='"+idx+"'/>";
		});
		return html;
	} // end of function getSearchListByCategory(data, sizeName, sizeNameKor, arrName, searchWord, className, url) ------------------------------
	
	// 선택한 카테고리의 모든 검색결과를 보여주기
	function showCategoryAll(category) {
		$(".allSearchResult").each(function(){
			$("div").removeClass("searchAllLine");
			if( $(this).hasClass(category) ) {
				$(this).show();	
			} else {
				$(this).hide();
			}
		});
		$("#returnAllResult").show();
		$("#searchWordByAll").focus();
	} // end of function showAllList(category) ---------------------------------------------------------------------------------------------------
	
	// 카테고리별 검색결과에서 모든 검색결과로 되돌아가기
	function returnAllResult() {
		$(".allSearchResult").each(function(){
			$("div").removeClass("searchAllLine");
			if( $(this).hasClass("firstShowResult") ) {
				$(this).show();	
			} else {
				$(this).hide();
			}
		});
		$("#returnAllResult").hide();
		$("#searchWordByAll").focus();
	} // end of function returnAllResult() ---------------------------------------------------------------------------------------------------
	
	// 사이드바 아이콘 변경을 위해 선택한 검색어가 속한 메뉴를 세션에 올리기
	function keepIcon(icon) {		
		var frm = {
    		"selectIcon":icon,
    		"toggleIcon":$("span.toggleText").is(":visible")
    	};
    	$.ajax({
    		url:"setSelectIconToSession.mr",
    		data:frm
    	});
	} // end of function keepIcon(icon) ------------------------------------------------------------------------------------------------
	
	// *** 통합검색에서 선택한 정보 보여주기 시작 ***
	function goSearchToProject(idx, url, icon, category) {
		keepIcon(icon);
		location.href=url+"?searchAllIdx="+idx+"&searchAllCategory="+category;
	} // end of function goSearchToProject(idx, url, icon, category) ---------------------------------------------------------------------------
	function goSearchToNotice(idx, url, icon, category) {
		keepIcon(icon);
		location.href=url+"?idx="+idx+"&userid=${sessionScope.loginUser.userid}&teamidx=${sessionScope.teamInfo.team_idx}";
	} // end of function goSearchToNotice(idx, url, icon, category) ---------------------------------------------------------------------------
	function goSearchToMind(idx, url, icon, category) {
		keepIcon(icon);
		location.href=url+"?idx="+idx+"&userid=${sessionScope.loginUser.userid}&teamNum=${sessionScope.teamInfo.team_idx}";
	} // end of function goSearchToNotice(idx, url, icon, category) ---------------------------------------------------------------------------
	function goSearchToFree(idx, url, icon, category) {
		keepIcon(icon);
		location.href=url+"?idx="+idx;
	} // end of function goSearchToNotice(idx, url, icon, category) ---------------------------------------------------------------------------
	// *** 통합검색에서 선택한 정보 보여주 끝 ***
	// ------------------------------------------------------ ***** 통합 검색 관련 함수 끝 ***** ------------------------------------------------------
</script>

<!-- 통합검색메뉴 -->
<div style="float: left; width: 30%; height: 50px;">
	<input type="text" class="form-control input-md" id="searchWordByAll" style="margin-left:10px; margin-top: 7px; background-color:#154465; color:white;" placeholder="통합검색"/>
</div>
<%-- <div style="width:50px; height: 50px; display:inline-block; float:left;" align="center">
	<a href="<%= request.getContextPath() %>/doList.mr" title="검색">
		<img src="<%= request.getContextPath() %>/resources/images/icon/14.png" class="iconPng headerIconPng" />
	</a>
</div> --%>
<div id="searchAllResult" style="display:inline-block; z-index:99999; max-height:500px; overflow:auto; position:absolute; background-color:#154465; color:white;"></div>

<!-- ===== 로그인 성공한 사용자 정보 출력 ===== -->
<c:if test="${sessionScope.loginUser != null}">
	<div style="float:right; padding:0px !important; border-left:3px solid #2c6994">
		<div onclick="javascript:location.href='<%= request.getContextPath() %>/tmForm.mr'" title="팀 선택" class="iconTag headerDiv">
			<img src="<%= request.getContextPath() %>/resources/images/icon/12.png" class="iconPng headerIconPng"/>
		</div>
		<div onclick="javascript:location.href='<%= request.getContextPath() %>/member_logout.mr'" title="로그아웃" class="iconTag headerDiv">
			<img src="<%= request.getContextPath() %>/resources/images/icon/13.png" class="iconPng headerIconPng"/>
		</div>
		<div onclick="javascript:showMyInfo();" title="${sessionScope.loginUser.name}(${sessionScope.loginUser.userid})" style="display:inline-block; cursor:pointer;">
			<img src="<%= request.getContextPath() %>/resources/files/${sessionScope.loginUser.img}" style="height: 50px; width: 50px;">
		</div>
	</div>
</c:if>

<!-- 내 정보 수정 모달 창 -->
<!-- Modal -->
<div class="modal modal-center fade" id="memberEditModal" role="dialog">
	<div class="modal-dialog modal-md modal-center">
		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h3 class="modal-title" style="text-align: center;">내 정보 수정</h3>
			</div>
			<div class="modal-body" id="modalBody" style="height: auto;">
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
		</div>

	</div>
</div>















