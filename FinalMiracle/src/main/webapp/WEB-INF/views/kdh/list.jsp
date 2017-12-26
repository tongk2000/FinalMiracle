<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<style type="text/css">
	table, th, td {border: solid gray 1px;}
	/* #table {border-collapse: collapse; width: 750px;} */
	
	.subjectstyle {font-weight: bold;
    	           color: navy;
    	           cursor: pointer; }
	
	/* === #142. 파일첨부가 되었으므로 테이블의 가로폭 늘리기 === */
	#table {border-collapse:collapse; width:920px;}
	#table th, #table td {padding:5px;}
	#table th {background-color:#DDDDDD;}
	.goSearch{cursor:pointer;}
	.selectSearchWord{background-color:lightblue;}
</style>

 
<script type="text/javascript">
	$(document).ready(function(){
		
		$(".subject").hover(function(event){
			 var $target = $(event.target);
			 $target.addClass("subjectstyle");
		}, function(event){
			 var $target = $(event.target);
			 $target.removeClass("subjectstyle");
		});
		
		$("#searchWord").keydown(function(){
			if(event.keyCode == 13) {
				if($(".goSearch").hasClass("selectSearchWord")) {
					var searchWord = $(".selectSearchWord").text().replace("제목:","");
					goSelectWord(searchWord);
					return false;
				}
			}
			
			if(event.keyCode == 40) { // down key 
				if($(".last").hasClass("selectSearchWord")) {
					return false;
				} else {
					if($(".goSearch").hasClass("selectSearchWord")) {
						$(".selectSearchWord").removeClass("selectSearchWord").next().addClass("selectSearchWord");
					} else {
						$(".first").addClass("selectSearchWord");
					}
				}
				return;
			}
			
			if(event.keyCode == 38) { // up key
				if($(".first").hasClass("selectSearchWord")) {
					$("#searchWordList").empty();
				} else {
					if($(".goSearch").hasClass("selectSearchWord")) {
						$(".selectSearchWord").removeClass("selectSearchWord").prev().addClass("selectSearchWord");
					} else {
						$(".last").addClass("selectSearchWord");
					}
				}
				return;
			}		
		});
		
		$("#searchWord").keyup(function(){
			if(event.keyCode == 13 || event.keyCode == 40) {
				if($(".goSearch").hasClass("selectSearchWord")) {
					return false;
				}
			} else if (event.keyCode == 38) {
				return false;
			}
			
			var colName = $("#colName").val();
			var searchWord = $("#searchWord").val();
			var frm = {"colName":colName, "searchWord":searchWord};
			if(searchWord != "") {
				$.ajax({
					url:"<%=request.getContextPath()%>/getSearchWordByKeyUp.action",
					data:frm,
					type:"get",
					dataType:"JSON",
					success:function(data){
						var html="";
						$.each(data, function(entryIndex, entry){
							var searchWordList = entry.searchWordList.replace(searchWord, "<span style='color:red;'>"+searchWord+"</span>");
							if(entryIndex == 0) {
								html += "<span class='first goSearch'>"+searchWordList+"<br/></span>";
							}
							if(entryIndex != 0 && entryIndex < data.length-1) {
								html += "<span class='goSearch'>"+searchWordList+"<br/></span>";
							}
							if(entryIndex == data.length-1 && data.length != 1) {
								html += "<span class='last goSearch'>"+searchWordList+"<br/></span>";
							}
						});
						$("#searchWordList").html(html);
					}, error:function(error){
						// alert(error);
					}	
				});
			} else {
				$("#searchWordList").html("");
			}
			
		});
		$(document).on("click", ".goSearch", function(){
			var searchWord = $(this).text().replace("제목:","");
			goSelectWord(searchWord);
		});
		
		$(document).on("mouseover", ".goSearch", function(){
			$(".goSearch").removeClass("selectSearchWord");
			$(this).addClass("selectSearchWord");
		});
		
		$(document).on("mouseout", ".goSearch", function(){
			$(".goSearch").removeClass("selectSearchWord");
		});
		
	});// end of $(document).ready()----------------------------------------------------------------------
	
	function goSelectWord(searchWord) {
		searchWord = searchWord.replace("내용:","");
		searchWord = searchWord.replace("작성자:","");
		$("#searchWord").val(searchWord);
		goSearch();
	}
	
	function searchKeep() {
		
		var colName = "${colName}";
		var searchWord = "${searchWord}";
		
		if(colName != "") {
			document.getElementById("colName").value = colName;
		}
		
		if(searchWord != "") {
			document.getElementById("searchWord").value = searchWord;
			document.getElementById("searchWord").focus();
		}
	} // end of function searchKeep() ----------------------------------------------------------------
	
	function goView(seq, goBackURL) {
		var frm = document.seqFrm;
		frm.seq.value = seq;
		frm.goBackURL.value = goBackURL;
		
		frm.method = "get";
		frm.action = "<%=request.getContextPath()%>/view.action";
		frm.submit();
		
	} // end of goView(seq, goBackURL) -------------------------------------------------------
	
	function goSearch() {
		var frm = document.searchFrm;
		frm.submit();
	} // end of function goSearch() ----------------------------------------------------------
</script>

<div style="padding-left: 10%; border: solid 0px red;">
	<h1>글목록</h1>
	
	<table id="table">
		<thead>
			<tr>
				<th style="width: 70px;" >글번호</th>
				<th style="width: 360px;" >제목</th>
				<th style="width: 70px;" >성명</th>
				<th style="width: 180px;" >날짜</th>
				<th style="width: 70px;" >조회수</th>
				
				<!-- === #141. 파일과 크기를 보여주도록 뷰단 수정 === -->
				<th style="width: 70px;" >파일</th>
				<th style="width: 100px;" >크기(bytes)</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="boardvo" items="${boardList}" varStatus="status"> 
				<tr>
					<td align="center">${boardvo.seq}</td>
					<td>
						<!-- === #127. 답변글인 경우 제목앞에┗Re 라는 글자를 붙이도록 한다. -->
						<!-- 답변글이 아닌 원글인 경우 -->
						<c:if test="${boardvo.depthno == 0}">
							<span class="subject" onClick="goView('${boardvo.seq}','${goBackURL}');">${boardvo.subject}&nbsp;
								<c:if test="${boardvo.commentCount > 0}">
									<span style="color:red; font-weight:bold; font-style:italic; font-size:small; vertical-align:sub;">[${boardvo.commentCount}]</span>
								</c:if>
							</span>
						</c:if>
						
						<!-- 답변글인 경우 -->
						<c:if test="${boardvo.depthno > 0}">
							<span class="subject" onClick="goView('${boardvo.seq}','${goBackURL}');">
								<span style="color:red; margin-left:${boardvo.depthno*15}px;">┗Re:</span>${boardvo.subject}&nbsp;
								<c:if test="${boardvo.commentCount > 0}">
									<span style="color:red; font-weight:bold; font-style:italic; font-size:small; vertical-align:sub;">[${boardvo.commentCount}]</span>
								</c:if>
							</span>
						</c:if>
					</td>
					<td>${boardvo.name}</td>
					<td align="center">${boardvo.regDate}</td>
					<td align="center">${boardvo.readCount}</td>
					
					<!-- === #143. 첨부파일 여부 표시하기 === -->
					<td align="center">
						<c:if test="${not empty boardvo.fileName}">
							<img src="<%=request.getContextPath()%>/resources/images/disk.gif" border="0" /> <!-- border="0" : 이미지에 틀이 보이면 없앤다. -->
						</c:if>
					</td>
					<td align="center">
						<c:if test="${not empty boardvo.fileName}">
							${boardvo.fileSize}
						</c:if>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<br/>
	<!-- === #115. 페이지바 보여주기 === -->
	<div align="center">
		${pageBar}
	</div>
	<form name="seqFrm">
		<input type="hidden" name="seq" />
		<input type="hidden" name="goBackURL" />
	</form>
	
	<!-- #102. 글검색 폼 추가하기 : 글제목, 내용, 글쓴이로 검색하겠다. -->
	<form name="searchFrm" action="<%=request.getContextPath()%>/list.action" method="get">
		<select name="colName" id="colName">
			<option value="'제목:'||subject">제목</option>
			<option value="'내용:'||content">내용</option>
			<option value="'제목:'||subject||' 내용:'||content">제목+내용</option>
			<option value="'작성자:'||name">작성자</option>
		</select>
		<input type="text" name="searchWord" id="searchWord" size="40px" />
		<input type="hidden"/> <!-- 엔터시 자동 submit 방지용 -->
		<button type="button" onClick="goSearch();">검색</button>
	</form>
	<div id="searchWordList"></div>
</div>













