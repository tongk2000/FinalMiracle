<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<style type="text/css">
	
	.subjectstyle {font-weight: bold;
    	           color: darkgray;
    	           cursor: pointer; }
    	           
	.faqContent {background-color: lightgray;
				 
				 font-weight: bold;} 
				  
	.category {display: inline;
			   cursor: pointer;
			   color: navy;
			   font-size: 13pt;}
	
	.answer {margin-left: 10px;
	min-height: null;
	max-height: null;}
	
	<%-- accordion css --%>
	dt, dd {
	  padding: 10px;
	}
	
	dt {
	  background-color: #cfc;
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
	  background-color: tan;
	  margin-bottom: 5px;
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
		// ============= *** 검색조건 유지 시키기 *** ===========================
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


<h1 style="margin-left: 20%;">자주 묻는 질문</h1>
<div style="margin-left: 10%; border: 1px solid red; width: 90%;">
	<!-- ========================================= *** Category 분류 항목 *** ================================= -->
	<div style="width: 90%;"> 
		<div class="category" style="margin-left:10%;">
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
	<div style="border: 1px solid pink; width: 90%;">
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
	
	<form name="seqFrm">
		<input type="hidden" name="seq" />
		<input type="hidden" name="gobackURL" />
	</form>
	
	<!-- ========================================================= *** 검색폼 만들기 *** ========================================== -->
	<div>
		<form name="searchFrm" action="<%= request.getContextPath() %>/faqList.mr" method="get">
			<select name="colname" id="colname" style="vertical-align: middle;">
				<option value="subject">제목</option>
			</select>
			<input type="text" id="search" name="search" size="40px" style="vertical-align: middle;" />
			<a onClick="goSearch();">[검색글 조회]</a>
		</form>
	</div>
	<br/>
	<!-- ======================================================== *** 페이지바 만들기 *** ========================================== --> 	
	<div>
		${pagebar}
	</div>

	<div style="margin-top: 20px; margin-bottom: 20px;">
		<button type="button" onClick="javascript:location.href='<%= request.getContextPath() %>/faqList.mr'">전체 글목록</button>&nbsp;
		<button type="button" onClick="javascript:location.href='<%= request.getContextPath() %>/faqAdd.mr'">글쓰기</button>
	</div>

</div>


<!-- category frm -->
<div>
	<form name="categoryFrm" action="<%= request.getContextPath() %>/faqList.mr" method="get">
		<input type="hidden" name="category" />
	</form>
</div>








