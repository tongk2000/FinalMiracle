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
	table {
		
		border: 1px solid black;
	}
	tr, th, td {
		border: 1px solid black;
		border-collapse:none;
		height:30px;
	}
	td, th {
		text-align:center;
	}
	.imgs {
		width:25px;
		height:25px;
	}
	div.min{
		height:10px;
		opacity:1.0;
	} 
	.subjectstyle {font-weight: bold;
    	           color: gray;
    	           cursor: pointer; }
   	.selectLine {
    	background-color:gray;
    }
    .image {
		width:50px;
		height:50px;
	}
	th {
		background-color:black;
		color:white;
	}
	.grayColor {
    	background-color:gray;
    	cursor: pointer;
    }
</style>
<script src="<%= request.getContextPath() %>/resources/js/jquery-2.0.0.js"></script>
<title>Mind 게시판 입니다!</title>
</head>
<body>
<c:set var="user" value="${userTeam}" />
	<div align="center" style="width:80%; margin:auto; border:red;">
		<h2>마음의 소리 게시판</h2>
		<form name="frm">
			<select id="searchType" name="searchType" style="font-size:12pt;">
				<option value="fk_userid">아이디</option>
				<option value="subject">제목</option>
			</select>
			<input type="text" id="searchString" name="searchString" />
			<button type="button" id="btnClick" onClick="goSearch();">검색</button><br/>
			<div><div class="min"><div class="min"><div class="min"><div class="min"><div class="min"><div class="min">
				<div id="displayList" style="background-color:red; width:150px; margin-left: 28px; border-top: 0px; border: solid black 1px;"></div>
			</div></div></div></div></div></div></div>
			<table style="width:100%;">
				<thead>
					<tr>
						<th>번호</th>		<!-- 번호 -->
						<th>아이디</th>	<!-- 아이디 -->
						<th>제목</th>		<!-- 제목 -->
						<th>글쓴 시간</th>	<!-- 글쓴 시간 -->
						<th>상태</th>		<!-- 조회수-->
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
								<td width="5%">${status.count}<input type="hidden" value="${md.d_idx}"/></td>	<!-- 번호 -->
								<c:if test="${md.tstatus == 2 || sessionScope.loginUser.userid == md.fk_userid}">
									<td width="15%">
										<a onClick="goUserInfo('${md.fk_userid}');">
											<img class="imgs" src="<%= request.getContextPath()%>/resources/images/${md.img}"/>  <span class="userid" >${md.fk_userid}</span>	<!-- 아이디 -->
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
								<td width="25%">${md.regday}</td>		<!-- 날짜 -->
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
							</tr>
						</c:forEach>
					</c:if>	
				</tbody>
			</table>
			<br/>
			<div style="float:right;">
				<c:if test="${user.status == 1}" >
					<button type="button" id="del">삭제</button>
					<button type="button" onClick="goWrite();">글쓰기</button>
				</c:if>
			</div>	
		</form>
		<br/><br/>
		${pagebar}
	</div>
	
	<form name="view">
		<input type="hidden" name="idx" />
		<input type="hidden" name="userid" />
		<input type="hidden" name="teamNum" />
	</form>
	<form name="write">
		<input type="hidden" name="userid" />
		<input type="hidden" name="teamNum" />
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
			frm.teamNum.value= "${user.teamNum}";
			frm.userid.value="${user.userid}";
			frm.action="<%=request.getContextPath()%>/mindWrite.mr";
			frm.method="post";
			frm.submit();
		}
	</script>
	<div class="modal fade" id="userinfo" role="dialog" style="z-index:1000;"></div>
</body>
</html>
