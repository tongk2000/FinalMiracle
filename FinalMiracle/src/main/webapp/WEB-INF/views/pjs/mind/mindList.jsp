<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
	/* div.min{
		height:10px;
		opacity:1.0;
	}  */
	.subjectstyle {font-weight: bold;
    	           color: gray;
    	           cursor: pointer; }
   	.selectLine {
    	background-color:#eaeaea;
    }
   /*  .image {
		width:50px;
		height:50px;
	} */
	/* th {
		background-color:#337ab7;
		color:white;
		font-size:12pt;
	} */
	.grayColor {
    	background-color:#eaeaea;
    	cursor: pointer;
    }
    #displayList {
    	position: absolute;
    	background-color:white;
    	width:189px; 
    	margin-left: 28px; 
    	border-top: 0px; 
    	border: solid gray 3px;
    }
</style>
<script src="<%= request.getContextPath() %>/resources/js/jquery-2.0.0.js"></script>
<title>Mind 게시판 입니다!</title>
</head>
<body>
 <c:set var="user" value="${userTeam}" />
	<%-- <div align="center" > 
	<div style="width:80%; border:red 3px dotted;" align="center">
		<h2>마음의 소리 게시판</h2>
			<table style="width:100%;">
				<thead>
					<tr>
						<th>번호</th>		<!-- 번호 -->
						<th>아이디</th>	<!-- 아이디 -->
						<th>제목</th>		<!-- 제목 -->
						<th>글쓴 시간</th>	<!-- 글쓴 시간 -->
						<th>첨부파일</th>
						<th>상태</th>		<!-- 조회수-->
						<th></th>	
					</tr>
				</thead>
				<tbody>
					<c:if test="${empty list}">
						<tr>
							<td colspan="6">데이터가 없습니다.</td>
						</tr>
					</c:if>
					<c:if test="${not empty list}">
						<c:forEach var="md" items="${list}" varStatus="status">
							<tr class="line"> <!-- d_idx, fk_userid subject regday readcount img, depth, status, t_idx, groupno, tstatus -->
								<td width="5%"><input type="hidden" value="${md.d_idx}"/><input type="checkbox"></td>	<!-- 번호 -->
								<c:if test="${md.tstatus == 2 || sessionScope.loginUser.userid == md.fk_userid}">
									<td width="15%">
										<a onClick="goUserInfo('${md.fk_userid}');">
											<img class="imgs" src="<%= request.getContextPath()%>/resources/images/${md.img}"/ style="width:30px; height:30px;">  <span class="userid" >${md.fk_userid}</span>	<!-- 아이디 -->
										</a>
									</td>
								</c:if>		
								<c:if test="${md.tstatus == 1 && sessionScope.loginUser.userid != md.fk_userid}">
									<td>익명</td>
								</c:if>
								<c:if test="${md.depth == 0}">
									<td width="45%" onClick="goView('${md.d_idx}','${md.fk_userid}', '${md.t_idx}')" style="text-align:left; padding-left:10px;"><span style="color:red; ">${md.subject}</span></td><!-- 제목 -->
								</c:if>
								<c:if test="${md.depth > 0}">
									<td width="45%" onClick="goView('${md.d_idx}','${md.fk_userid}','${md.t_idx}')" style="padding-left:${md.depth*10}px; color:black; font-weight:bold; text-align:left;">└ [답글] ${md.subject}</td><!-- 제목 -->
								</c:if>		<!-- 제목 -->
								<td width="20%">${md.regday}</td>		<!-- 날짜 -->
								
								<c:if test="${md.file > 0}">
								    <td width="5%" style="text-align:center;"><img src="<%=request.getContextPath() %>/resources/images/disk.gif" ></td>
								</c:if>
								<c:if test="${md.file == 0}">
								    <td width="5%" style="text-align:center;">X</td>
								</c:if>
									
								<td width="10%">
								<c:if test="${md.depth == 0}">
									<c:if test="${md.readcount == 0}" >
										대기중
									</c:if>
									<c:if test="${md.readcount > 0 && md.checkNum == 0}" >
										확인
									</c:if>
									<c:if test="${md.checkNum > 0}" >
										답변완료
									</c:if>
								</c:if>	
								<c:if test="${md.depth > 0}">
									답변
								</c:if>
								</td>	<!-- 조회수-->
								<c:if test="${md.fk_userid == sessionScope.loginUser.userid}">
									<td width="5%"><button type="button" onClick="goEditView('${md.d_idx}','${md.fk_userid}', '${md.t_idx}');">수정</button></td>
								</c:if>
								<c:if test="${md.fk_userid != sessionScope.loginUser.userid}">
									<td width="5%"></td>
								</c:if>
							</tr>
							<input type="hidden" id="midx" value="${md.d_idx}"/>	
						</c:forEach>
					</c:if>	
				</tbody>
			</table>
			<br/>
			<div align="center" style="padding-bottom:20px;">
				${pagebar}
			</div>	
			<div style="float:right;">
					<c:if test="${user.status == 1}" >
						<button type="button" id="del">삭제</button>
						<button type="button" onClick="goWrite();">글쓰기</button>
					</c:if>
			</div>
			<br/><br/>
			<form name="frm">
				<select id="searchType" name="searchType" style="font-size:12pt;">
					<option value="fk_userid">아이디</option>
					<option value="subject">제목</option>
				</select>
				<input type="text" id="searchString" name="searchString" />
				<button type="button" id="btnClick" onClick="goSearch();">검색</button><br/><br/><br/>
				<div style="display:block; z-index:1000; margin-top:-40px;" align="center">
					<div id="displayList" ></div>
				</div>
			</form>
		</div>
	</div>  --%>
	<form name="view">
		<input type="hidden" name="idx" />
		<input type="hidden" name="userid" />
		<input type="hidden" name="teamNum" />
	</form>
	<form name="write">
		<input type="hidden" name="idx"/>
		<input type="hidden" name="userid" />
		<input type="hidden" name="teamNum" />
	</form>
	<form name="edit">
		<input type="hidden" name="idx" />
		<input type="hidden" name="userid" />
		<input type="hidden" name="teamNum" />
	</form>
	<div align="center">
		<div style="display:block; width:90%; padding-top:30px;" align="center"> 
			<div class="panel panel-primary">
				<div class="panel-heading"></div>
				<div style=" border:3px solid #337ab7; "> <!-- width:500px; -->
				 <span style="color:red"> 마음의 소리 글 </span><br/>
				 <span style="color:skyblue;">팀 프로젝트에 대해 속마음을 털업!</span>
				</div><br/>
				<table class="table table-hover" id="dev-table">
					<thead>
						<tr>
							<th style="text-align:center; font-family:verdana;">번호</th>		<!-- 번호 -->
							<th style="text-align:center; font-family:verdana;">아이디</th>	<!-- 아이디 -->
							<th style="text-align:center; font-family:verdana;">제목</th>		<!-- 제목 -->
							<th style="text-align:center; font-family:verdana;">글쓴 시간</th>	<!-- 글쓴 시간 -->
							<th style="text-align:center; font-family:verdana;">첨부파일</th>
							<th style="text-align:center; font-family:verdana;">상태</th>		<!-- 조회수-->
							<th style="text-align:center; font-family:verdana;"></th>	
						</tr>
					</thead>
					<tbody>
					<c:if test="${empty list}">
						<tr>
							<td colspan="6">데이터가 없습니다.</td>
						</tr>
					</c:if>
					<c:if test="${not empty list}">
						<c:forEach var="md" items="${list}" varStatus="status">
							<tr class="line"> <!-- d_idx, fk_userid subject regday readcount img, depth, status, t_idx, groupno, tstatus -->
								<td width="5%" style="text-align:center; font-family:verdana;"><input type="hidden" value="${md.d_idx}"/><input type="checkbox"></td>	<!-- 번호 -->
								<c:if test="${md.tstatus == 2 || sessionScope.loginUser.userid == md.fk_userid}">
									<td width="15%" style="text-align:center; font-family:verdana;">
										<a onClick="goUserInfo('${md.fk_userid}');">
											<img class="imgs" src="<%= request.getContextPath()%>/resources/images/${md.img}" style="width:30px; height:30px;">  <span class="userid" >${md.fk_userid}</span>	<!-- 아이디 -->
										</a>
									</td>
								</c:if>		
								<c:if test="${md.tstatus == 1 && sessionScope.loginUser.userid != md.fk_userid}">
									<td style="text-align:center; font-family:verdana;">익명</td>
								</c:if>
								<c:if test="${md.depth == 0}">
									<td width="35%" onClick="goView('${md.d_idx}','${md.fk_userid}', '${md.t_idx}')" style="text-align:left; padding-left:10px; font-family:verdana;"><span style="color:red; ">${md.subject}</span></td><!-- 제목 -->
								</c:if>
								<c:if test="${md.depth > 0}">
									<td width="35%" onClick="goView('${md.d_idx}','${md.fk_userid}','${md.t_idx}')" style="padding-left:${md.depth*10}px; color:black; font-weight:bold; text-align:left;  font-family:verdana;">└ [답글] ${md.subject}</td><!-- 제목 -->
								</c:if>		<!-- 제목 -->
								<td width="20%" style="text-align:center; font-family:verdana;">${md.regday}</td>		<!-- 날짜 -->
								
								<c:if test="${md.file > 0}">
								    <td width="8%" style="text-align:center; font-family:verdana;"><img src="<%=request.getContextPath() %>/resources/images/disk.gif" ></td>
								</c:if>
								<c:if test="${md.file == 0}">
								    <td width="8%" style="text-align:center; font-family:verdana;">X</td>
								</c:if>
									
								<td width="7%" style="text-align:center; font-family:verdana;">
								<c:if test="${md.depth == 0}">
									<c:if test="${md.readcount == 0}" >
										대기중
									</c:if>
									<c:if test="${md.readcount > 0 && md.checkNum == 0}" >
										확인
									</c:if>
									<c:if test="${md.checkNum > 0}" >
										답변완료
									</c:if>
								</c:if>	
								<c:if test="${md.depth > 0}">
									답변
								</c:if>
								</td>	<!-- 조회수-->
								<c:if test="${md.fk_userid == sessionScope.loginUser.userid}">
									<td width="15%" style="text-align:center; font-family:verdana;"><button type="button" onClick="goEditView('${md.d_idx}','${md.fk_userid}', '${md.t_idx}');">수정</button></td>
								</c:if>
								<c:if test="${md.fk_userid != sessionScope.loginUser.userid}">
									<td width="15%" style="text-align:center; font-family:verdana;"></td>
								</c:if>
							</tr>
							<input type="hidden" id="midx" value="${md.d_idx}"/>	
						</c:forEach>
					</c:if>	
				</tbody>
			</table>
		</div>
	</div>	
	</div>
	<div align="center" style="padding-bottom:20px;">
		${pagebar}
	</div>	
	<div style="float:right;">
			<c:if test="${user.status == 1}" >
				<button type="button" id="del">삭제</button>
				<button type="button" onClick="goWrite();">글쓰기</button>
			</c:if>
	</div>
	<br/><br/>
	<form name="frm">
		<select id="searchType" name="searchType" style="font-size:12pt;">
			<option value="fk_userid">아이디</option>
			<option value="subject">제목</option>
		</select>
		<input type="text" id="searchString" name="searchString" />
		<button type="button" id="btnClick" onClick="goSearch();">검색</button><br/><br/><br/>
		<div style="display:block; z-index:1000; margin-top:-40px;" align="center">
			<div id="displayList" ></div>
		</div>
	</form>
	
	<script>
		$(document).ready(function(){
			keep();
			$("#del").click(function(){
				var cnt=0;
				var idx = new Array();
				$(".selectLine").each(function(){
					idx[cnt] = $(this).find("input").val();
					cnt++;
					alert("idx"+$(this).find("input").val());
				});
				location.href="<%=request.getContextPath()%>/mindDel.mr?idx="+idx;
			});
			// 페이지 전체에서 esc 키를 누르면 모달창을 닫기
			$(document).on("keydown", function(){
			   var modalFlag = $('#userinfo').is(':visible');
			   if (event.keyCode == 27 && modalFlag) {
			      $('#userinfo').modal('hide');
			   }
			}); // end of $(document).on("keydown", function()
			// 모달창에서 x 나 취소를 누르면 모달창을 닫기
			$(document).on("click", ".modalClose", function(){         
			 $('#userinfo').modal('hide');
			}); // end of $(".modalClose").click(function() ------------------------------------------------------------------------------------------------------

			$("tr:has(td)").click(function(){ // tr중에서 td를 가지고 있는 tr
				var bool = $(this).hasClass("selectLine"); // 한번 더 클릭하면 클래스 삭제
				if(bool) {
					$(this).removeClass("selectLine");
				}
				else {
					$(this).addClass("selectLine");
				}
			});
			$("#displayList").hide();
			$("#searchString").keyup(function(){
				if($("#searchType").val()==null||$("#searchType").val()=="") {
					$("#searchType").val("fk_userid");
				}
				var data_form = {"searchString":$("#searchString").val(), "searchType":$("#searchType").val()};
				$.ajax({
					url:"mindListJSON.mr",
					type:"get",
					data:data_form,
					dataType:"JSON",
					success: function(data) {
						var resultHTML ="";
						if(data.length > 0) { // 검색된 데이터가 있는 경우라면
							$.each(data, function(entryIndex, entry){
								var wordstr = entry.search;
								var index = wordstr.toLowerCase().indexOf( $("#searchString").val().toLowerCase() );
								var len = $("#searchString").val().length;
								var result = "";
								result = "<span class='first' style='color:blue;'>" +wordstr.substr(0, index)+ "</span>" + "<span class='second' style='color:red; font-weight:bold;'>" +wordstr.substr(index, len)+ "</span>" + "<span class='third' style='color:blue;'>" +wordstr.substr(index+len, wordstr.length - (index+len) )+ "</span>";  
								resultHTML += "<span style='cursor:pointer;'>"+ result +"</span><br/>"; 
							});
							var left = $("#searchString").position().left-28;
							var top = $("#searchString").position().top+5	;
							top = top + ($("#searchString").height());
							$("#displayList").css({"left":left+"px", "top":top+"px"});
							$("#displayList").html(resultHTML);
							$("#displayList").show();
						}
						else {
							// 검색된 데이터가 존재하지 않는 경우라면
							$("#displayList").hide();
						} // end of if ~ else ----------------
					}, // end of success: function()----------
					error: function(){
						
					}
				}); // end of $.ajax()------------------------
			}); // end of keyup(function(){})-----------------
			$(".line").hover(function(){ 
				$(this).addClass("grayColor");
			},function(){
				$(this).removeClass("grayColor");
			});
			$("#displayList").click(function(event){
				var word = "";
				var $target = $(event.target);
				if($target.is(".first")) {
					word = $target.text() + $target.next().text() + $target.next().next().text();
				}
				else if($target.is(".second")) {
					word = $target.prev().text() + $target.text() + $target.next().text();
				}
				else if($target.is(".third")) {
					word = $target.prev().prev().text() + $target.prev().text() + $target.text();
				}
				$("#searchString").val(word); // 텍스트박스에 검색된 결과의 문자열을 입력해준다.
				$("#displayList").hide();
			});
		});
		function keep() {
			<c:if test="${searchType!=null&&searchType!=''}">
				$("#searchType").val("${searchType}");
			</c:if>
			<c:if test="${searchType!=null&&searchType!=''}">
				$("#searchType").val("${searchType}");
			</c:if>
		}
		function goSearch() {
			var frm = document.frm;
			frm.action="<%=request.getContextPath()%>/mindList.mr";
			frm.method="get";
			frm.submit();
		}
		function goUserInfo(id) {
			var userid = {"userid":id};
			$.ajax({
				url:"mindUserInfo.mr",
				type:"get",
				data:userid,
				dataType:"html",
				success: function(data) {
					if(data.length>0) {
						$("#userinfo").html(data);
						$("#userinfo").modal();
					}
					else {
						alert("ajax결과"+data);
					}
				},error : function() {
					alert("실패!");
				}
			});
		}
		function goView(d_idx, userid, teamNum) {
			var frm = document.view;
			frm.idx.value = d_idx;
			frm.userid.value = userid; 
			frm.teamNum.value = teamNum;
			frm.action="<%=request.getContextPath()%>/mindView.mr";
			frm.method="get";
			frm.submit();
		}
		function goWrite() {
			var frm = document.write;
			frm.idx.value=$("#midx").val();
			frm.teamNum.value= "${user.teamNum}";
			frm.userid.value="${user.userid}";
			frm.action="<%=request.getContextPath()%>/mindWrite.mr";
			frm.method="post";
			frm.submit();
		}
		function goEditView(d_idx, userid, teamNum) {
			var frm = document.edit; //userid, 글번호(idx), teamNum 
			frm.idx.value = d_idx;
			frm.userid.value = userid; 
			frm.teamNum.value = teamNum;
			frm.action="<%=request.getContextPath()%>/mindViewEdit.mr";
			frm.method="post";
			frm.submit();
		}
	</script>
	<div class="modal fade" id="userinfo" role="dialog" style="z-index:1000;"></div>
</body>
</html>
