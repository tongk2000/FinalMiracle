<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<style type="text/css">
	.clickButtonStyle {
		font-weight: bold;
		font-style: italic;
	    color: #223A5E;
	    cursor: pointer; 
    }
	.subjectstyle {
		font-weight: bold;
	    color: dimgray;
	    cursor: pointer; 
    }
    	           
	.faqContent {
		background-color: lightgray;				 
		font-weight: bold;
	} 
				  
	.category {
		display: inline;
		cursor: pointer;
		color: navy;
		font-size: 13pt;
	}
	
	<%-- 아코디언 css --%>
	.layer1 {
		margin: 0;
		padding: 0;
		width: 500px;
	}
	
	.subject {
		margin: 5px;
		color: #404040;
		padding: 5px 10px;
		cursor: pointer;
		position: relative;
		border: 1px solid #989898;
		border-left: none;
		border-right: none;
		font-weight: bold;
		font-size: 12pt;
	}
	.content {
		border-radius: 15px;
		margin-left: 20px;
		padding: 5px;
		background-color: whitesmoke;
	}
	
	p { padding: 5px 0; }
	
	.faqListRowCssStyle {
		background-color: #F0F0F0;
	}

</style>

 
<script type="text/javascript">
	$(document).ready(function(){
		// ================================= *** FAQ게시판 제목에 마우스 가져갈 경우 / 다른곳으로 이동한 경우 *** =========
		$(".subject").bind("mouseover", function(event){
			 var $target = $(event.target);
			 $target.addClass("subjectstyle");
		}); 
		$(".subject").bind("mouseout", function(event){
			 var $target = $(event.target);
			 $target.removeClass("subjectstyle");
		});
		// ================================================== *** 목록보기, 글쓰기, 검색 에 마우스 댈경우 css 효과 *** ========
		$(".clickButton").bind("mouseover", function(event){
			 var $target = $(event.target);
			 $target.addClass("clickButtonStyle");
		}); 
		$(".clickButton").bind("mouseout", function(event){
			 var $target = $(event.target);
			 $target.removeClass("clickButtonStyle");
		});
		// ============= *** 검색조건 유지 시키기 *** ============
		searchKeep();
		
		// =================== *** accordion으로 FAQ 내용물 보여주기  *** =====================================	
	    jQuery(".content").hide();
			//content 클래스를 가진 div를 표시/숨김(토글)
		  $(".subject").click(function()
		  {
		    $(".content").not($(this).next(".content").slideToggle(500)).slideUp();
		  });
		// ========================== accordion으로 FAQ 내용물 보여주기  끝 ===========================================
			
		// ================================== *** 자유게시판 목록 행 전체에 hover 효과 주기 *** ============================
		$(".faqListRow").hover(function(){ 
			$(this).addClass("faqListRowCssStyle");
		},function(){
			$(this).removeClass("faqListRowCssStyle");
		});
	});  // end of $(document).ready() ----------------------------------
	
	// ===================================================== *** 검색폼에 입력한 검색값 유지 하는 함수 *** ================
	function searchKeep() {
		<c:if test="${(colname != 'null' && not empty colname) && (search != 'null' && not empty search) }">
			$("#colname").val("${colname}");
			$("#search").val("${search}");
		</c:if>
	}
	// ====================================================== *** 검색어 입력시 Frm값 전송 해주는 함수 *** ================
	function goSearch() {
		var frm = document.searchFrm;
		var search = $("#search").val();
		
		if(search.trim() == "") {
			alert("검색어를 입력한 후 다시 시도해 주십시오.");
			return;
		} else {
			frm.submit();
		}
	}
	
	// ====================================================== *** 카테고리 분류 메뉴 클릭시 *** =========================
	function goCategory(category) {
		var frm = document.categoryFrm;
		
		frm.category.value = category;
		frm.submit();
	}

</script>

<body>

<div style="width: 100%; height: 100%; border: 0px dotted pink; padding-top: 10px; overflow-y: hidden; " align="center">
	<div style="border: 0px solid orange; width: 800px;">
		<!-- ============================= *** FAQ 게시판 소개 *** =================================== -->
		<div style="width: 800px; border: 0px dotted maroon;" align="left">
			<table>
				<tr class="title above"">
					<td colspan="2" style="background-color: lightblue; border: 1px solid lightgray; border-left: none; border-right: none; padding: 5px; font-weight: bold; font-size: 11pt;">자주 묻는 질문(FAQ) 게시판입니다.</td>
				</tr>
				<tr class="title">
				<td colspan="2" style="padding-left: 10px; padding-right: 10px; padding-top: 5px; border: 1px solid lightgray; border-left: none; border-right: none; font-size: 9pt;">
					Question 클릭시 Answer 내용을 열람할 수 있습니다.<br/>
					공지사항은 <a href="<%= request.getContextPath() %>/noticeList.mr">공지사항게시판</a> 
					자유게시물 등록을 원하시는 회원님은 <a href="<%= request.getContextPath() %>/freeList.mr">자유게시판</a> 기능을 이용해주시기 바랍니다.
				</td>
				</tr>
				<!-- ============================= *** 공 백 *** ================================ -->
				<tr style="border: 0px solid lightgray; border: none;">
					<td colspan="2" style="padding-left: 20px;">
						<br/>
						<c:if test="${search == null}">
							<span style="font-family: verdana; font-weight: bold;">총 게시물 ' 
								<span style="color: #92a8d1; font-size: larger;">${totalCount}</span> ' 개
							</span>
						</c:if> 
						<c:if test="${search != null}">
							<span style="font-family: verdana; font-weight: bold;">검색된 게시물 ' 
								<span style="color: #92a8d1; font-size: larger;">${totalCount}</span> ' 개
							</span>
						</c:if> 
					</td>
				</tr>
			</table>
		</div>
		
		<div style="border: 0px dotted blue; width: 800px;">
			<!-- ========================================= *** Category 분류 항목 *** ================================= -->
			<!-- 
			<div style="width: 650px; padding: 10px; margin-left: 30px; margin-bottom: 20px; border-radius: 20px; background-color: #E8E8E8; float: left;" align="left"> 
				<div class="category" style="margin-left: 8%;">
					<a onClick="goCategory(0)"><span style="font-family: sans-serif; font-size: 13pt; font-weight: bold; ">기타문의</span></a>
				</div>
				<div class="category" style="margin-left:10%;">
					<a onClick="goCategory(1)"><span style="font-family: sans-serif; font-size: 13pt; font-weight: bold; ">회원관련</span></a>
				</div>				
				<div class="category" style="margin-left:10%;">
					<a onClick="goCategory(2)"><span style="font-family: sans-serif; font-size: 13pt; font-weight: bold; ">상담관련</span></a>
				</div>				
				<div class="category" style="margin-left:10%;">
					<a onClick="goCategory(3)"><span style="font-family: sans-serif; font-size: 13pt; font-weight: bold; ">업무관련</span></a>
				</div>	
			</div>
			 -->
			<!-- ========================================== *** accordion FAQ 게시판 목록 *** ============================== -->
			<div style="border: 0px dashed green; width: 800px; float: left; display: block;" align="left">
				<div class="layer1" style="width: 700px;">

					<c:forEach var="faq" items="${faqList}" varStatus="status">
					  <p class="subject faqListRow">
					  	<span style="color: red; font-weight: bold;">[ Q ] </span>${faq.subject}
					  </p>
					  <div class="content">
					  	<span style="color: blue; font-weight: bold;">[ A ]</span><br/>
					  	<span style="font-weight: bold;">${faq.content}<br/></span>
					  </div>
					</c:forEach>

				</div>
				<!-- =================== *** 검색 박스  *** =========================== -->
				<div style="float: right; margin-right: 100px; display: inline-block;">
					<form name="searchFrm" action="<%= request.getContextPath() %>/faqList.mr" method="get">
						<select name="colname" id="colname" style="vertical-align: middle; height: 22px;">
							<option value="subject">제목</option>
							<option value="content">내용</option>
						</select>
						<input type="text" id="search" name="search" size="30" style="vertical-align: middle; height: 22px;" />
						<a onClick="goSearch();" class="clickButton" style="font-size: 10pt; font-family: georgia; text-decoration: none; color: black; cursor: pointer;">검색</a>
					</form>
				</div>
				
				<!-- =================== *** 목록보기, 글쓰기 버튼 *** ================= -->
				<div style="float: left; display: inline-block; margin-left: 10px;">
					<span class="clickButton" style="font-size: 10pt; font-family: sans-serif; font-weight: bold;" onClick="javascript:location.href='<%= request.getContextPath() %>/faqList.mr'">목록보기</span>&nbsp;&nbsp;
					<span class="clickButton" style="font-size: 10pt; font-family: sans-serif; font-weight: bold;" onClick="javascript:location.href='<%= request.getContextPath() %>/faqAdd.mr'">글쓰기</span>
				</div>
				
				<!-- =================== *** 페이지바 *** ====================== --> 	
				<div style="clear: both; margin-right: 100px;" align="center">
					${pagebar}
				</div>
			</div>
		
		</div>
	</div>
</div>

</body>




<!-- 카테고리번호 전송을 위한 category frm -->
<%-- 
<form name="categoryFrm" action="<%= request.getContextPath() %>/faqList.mr" method="get">
	<input type="hidden" name="category" />
</form>

 --%>







