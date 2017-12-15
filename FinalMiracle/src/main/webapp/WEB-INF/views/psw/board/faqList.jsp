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
	    color: white;
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
	
	
	<%-- accordion css --%>
	dt, dd {
	  padding: 10px;
	}
	
	dt {
	  border-radius: 5px;
	  background-color: #92B6D5;
	  margin-bottom: 5px;
	}
	
	dt span {
	  display: inline-block;
	  width: 5px;
	  height: 5px;
	  background-color: black;
	  vertical-align: middle;
	  margin-right: 10px;
	}
	 
	dt.on span {
	  background-color: red;
	}
 	
	dd {
	  border-radius: 5px;
	  background-color: tan;
	  margin-bottom: 5px;
	  margin-left: 15px;
	  display: none;
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
		var acodian = {
			  click: function(target) {
			    var _self = this, $target = $(target);
			    $target.on('click', function() {
			      var $this = $(this);
			      if ($this.next('dd').css('display') == 'none') {
			        $('dd').slideUp();
			        _self.onremove($target);
		
			        $this.addClass('on');
			        $this.next().slideDown();
			      } else {
			        $('dd').slideUp();
			        _self.onremove($target);
			      }
			    });
			  },
			  onremove: function($target) {
			    $target.removeClass('on');
			  }
			};
			acodian.click('dt');
		// ========================== accordion으로 FAQ 내용물 보여주기  끝 ===========================================

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

<div style="width: 100%; border: 3px dotted pink; padding-top: 10px;" align="center">
	<div style="border: 1px solid orange; width: 800px;">
		<!-- ============================= *** 자유게시판 소개 *** =================================== -->
		<div style="width: 800px; border: 1px dotted maroon;" align="left">
			<table>
				<tr class="title above">
					<td colspan="2" style="background-color: lightblue; padding-left: 20px; font-weight: bold; font-size: 11pt;">자주 묻는 질문(FAQ) 게시판입니다.</td>
				</tr>
				<tr class="title">
				<td colspan="2" style="padding-left: 10px; padding-right: 10px; padding-top: 5px; border: 1px solid lightgray; border-left: none; border-right: none; font-size: 9pt;">
					카테고리별 분류 검색과 Q(제목) A(내용) 검색기능을 이용 가능합니다. Question 클릭시 Answer 내용을 열람할 수 있습니다.<br/><br/>
					공지사항은 <a href="<%= request.getContextPath() %>/noticeList.mr">공지사항게시판</a> 
					자유게시물 등록을 원하시는 회원님은 <a href="<%= request.getContextPath() %>/freeList.mr">자유게시판</a> 기능을 이용해주시기 바랍니다.
				</td>
				</tr>
				<!-- ============================= *** 공 백 *** ================================ -->
				<tr style="border: 0px solid lightgray; border: none;">
					<td colspan="2" style="padding-left: 20px;">
					</td>
				</tr>
			</table>
		</div>
		
		<div style="border: 1px dotted blue; width: 800px; padding-top: 10px;">
			<!-- ========================================= *** Category 분류 항목 *** ================================= -->
			<div style="width: 800px; padding-bottom: 10px;"> 
				<div class="category" style="clear: both;">
					<a onClick="goCategory(0);">[기타문의]</a>
				</div>
				<div class="category" style="margin-left:10%;">
					<a onClick="goCategory(1)">[회원관련]</a>
				</div>				
				<div class="category" style="margin-left:10%;">
					<a onClick="goCategory(2)">[상담관련]</a>
				</div>				
				<div class="category" style="margin-left:10%;">
					<a onClick="goCategory(3)">[업무관련]</a>
				</div>	
			</div>
			
			<!-- ========================================== *** accordion FAQ 게시판 목록 *** ============================== -->
			<div style="border: 1px dashed green; width: 700px;" align="left">
				<div style="width: 700px;">
					<dl>
						<c:forEach var="faq" items="${faqList}" varStatus="status">
						  <dt class="subject">
						  	<span style="color: red;">Q.</span>${faq.subject}
						  </dt>
						  <dd class="answer">
						  	<span style="color: blue; font-weight: bold;">[ A ]</span><br/>${faq.content}<br/>
						  </dd>
						</c:forEach>
					</dl>
				</div>
				<!-- =================== *** 검색 박스  *** =========================== -->
				<div style="float: right; margin-right: 10px;">
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
				<div style="float: left; margin-left: 10px;">
					<span class="clickButton" style="font-size: 10pt; font-family: sans-serif; font-weight: bold;" onClick="javascript:location.href='<%= request.getContextPath() %>/faqList.mr'">목록보기</span>&nbsp;&nbsp;
					<span class="clickButton" style="font-size: 10pt; font-family: sans-serif; font-weight: bold;" onClick="javascript:location.href='<%= request.getContextPath() %>/faqAdd.mr'">글쓰기</span>
				</div>
				
				<!-- =================== *** 페이지바 *** ====================== --> 	
				<div style="clear: both;">
					${pagebar}
				</div>
			</div>
		
		</div>
	</div>
</div>

</body>

<!-- 글번호 전송을 위한 폼 -->
<form name="idxFrm">
	<input type="hidden" name="idx" />
</form>


<!-- 카테고리번호 전송을 위한 category frm -->
<div>
	<form name="categoryFrm" action="<%= request.getContextPath() %>/faqList.mr" method="get">
		<input type="hidden" name="category" />
	</form>
</div>








