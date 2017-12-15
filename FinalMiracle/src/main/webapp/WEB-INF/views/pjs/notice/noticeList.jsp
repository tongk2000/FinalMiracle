<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
%>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
		padding:7px;
	}
	th {
		text-align:center;
		background-color:black;
		color:white;
	}
	td {
		padding-left:5px;
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
    .grayColor {
    	background-color:gray;
    	cursor: pointer;
    }
    .selectLine {
    	background-color:gray;
    }
</style>
<title>Notice 게시판 입니다!</title>
</head>
<body>
	<c:set var="team" value="${userTeam}"></c:set>
	<div align="center" >
		<h2>공지사항 게시판</h2>
			
			<table style="width:90%;">
				<thead>
					<tr>
						<th>번호</th>		<!-- 번호 -->
						<th>아이디</th>	<!-- 아이디 -->
						<th>제목</th>		<!-- 제목 -->
						<th>첨부파일</th>
						<th>글쓴 시간</th>	<!-- 글쓴 시간 -->
						<th>조회수</th>	<!-- 조회수-->
					</tr>
				</thead>
				<tbody>
					<c:if test="${empty list}">
						<tr>
							<td colspan="6">데이터가 없습니다.</td>
						</tr>
					</c:if>
					<c:if test="${not empty list}">
						<c:forEach var="nt" items="${list}" varStatus="status">
							<tr class="line">
								<td width="5%" style="text-align:center;"><input type="checkbox"><input type="hidden" value="${nt.n_idx}"/></td><!-- 번호 -->
								<td width="15%" style="padding-left:10px;">
									<a onClick="goUserInfo('${nt.fk_userid}');"> <!-- 유저아이디 -->
										<img src="<%= request.getContextPath()%>/resources/images/${nt.img}" class="imgs" /> 
										<span class="userid">${nt.fk_userid}</span>
									</a>
								</td>	
							<c:if test="${nt.depth == 0}">
									<td width="35%" onClick="goView('${nt.n_idx}','${nt.fk_userid}', '${nt.t_idx}')"><span style="color:red; margin-left:10px;">${nt.subject} <span style="color:blue">&nbsp;&nbsp;&nbsp;[댓글 수 : ${nt.count}]</span></span></td><!-- 제목 -->
							</c:if>
							<c:if test="${nt.depth > 0}">
									<td width="35%" onClick="goView('${nt.n_idx}','${nt.fk_userid}','${nt.t_idx}')" style="margin-left:10px; padding-left:${nt.depth*10}px; color:black; font-weight:bold; ">└ [답글] ${nt.subject} <span style="color:blue">&nbsp;&nbsp;&nbsp;[댓글 수 : ${nt.count}]</span></td><!-- 제목 -->
							</c:if>
							<c:if test="${nt.file > 0}">
								    <td width="10%" style="text-align:center;"><img src="<%=request.getContextPath() %>/resources/images/disk.gif" ></td>
							</c:if>	
							<c:if test="${nt.file == 0}">
								    <td width="10%" style="text-align:center;">X</td>
							</c:if>	
								<td width="25%" style="text-align:center;">${nt.regday}</td><!-- 날짜 -->
								<td width="10%" style="text-align:center;">${nt.readcount}</td><!-- 조회수 -->
							</tr>
							<input type="hidden" id="nidx"name="aidx" value="${nt.n_idx}"/>		
						</c:forEach>
					</c:if>
				</tbody>
			</table>
		<div style="float:right; border:1px dotted red">
			<br/>
			<c:if test="${team.status == 2}" >
				<button type="button" onClick="goWrite();">글쓰기</button>
				<button type="button" id="del" >삭제</button>
			</c:if>
		</div>
		<br/><br/>
		<div style="margin: 0 auto;">
			${pagebar}
		</div>
		<br/><br/>
		<form name="frm">
			<%-- <c:if test="${fn:length(team) > 1}" >
				<select id="teamNum" name="teamNum" style="font-size:12pt;">
					<c:forEach var="t" items="${team}">
						<option value="${t.teamNum}">${t.teamNum}팀</option>
					</c:forEach>	
				</select>
			</c:if> --%>
			<select id="searchType" name="searchType" style="font-size:12pt; ">
				<option value="fk_userid">아이디</option>
				<option value="subject">제목</option>
			</select>
			<input type="text" id="searchString" name="searchString" />
			<button type="button" id="btnClick" onClick="goSearch();">검색</button><br/>
		</form>
		<div style="z-index:2000;">
				<div id="displayList" style="background-color:white; width:176px; margin-left: 28px; border-top: 0px; border: solid gray 3px;"></div>
		</div>
	</div>
	<form name="view">
		<input type="hidden" name="idx" />
		<input type="hidden" name="userid" />
		<input type="hidden" name="teamidx" />
	</form>
	<form name="write">
		<input type="hidden" name="idx" />
		<input type="hidden" name="userid" />
		<input type="hidden" name="teamNum" />
	</form>
	<script>
		$(document).ready(function(){
			$("tr:has(td)").click(function(){ // tr중에서 td를 가지고 있는 tr
				var bool = $(this).hasClass("selectLine"); // 한번 더 클릭하면 클래스 삭제
				alert(bool);
				if(bool) {
					$(this).removeClass("selectLine");
				}
				else {
					$(this).addClass("selectLine");
				}
			});
			$("#del").click(function(){
				var cnt=0;
				var idx = new Array();
				$(".selectLine").each(function(){
					idx[cnt] = $(this).find("input").val();
					cnt++;
				});
				location.href="<%=request.getContextPath()%>/noticeDel.mr?idx="+idx;
			});
			keep();
			$("#displayList").hide();
			$("#searchString").keyup(function(){
				if($("#searchType").val()==null||$("#searchType").val()=="") {
					$("#searchType").val("fk_userid");
				}
				var data_form = {"searchString":$("#searchString").val(), "searchType":$("#searchType").val(), "t_idx":${team.teamNum}};
				$.ajax({
					url:"noticeListJSON.mr",
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
			$(".line").hover(function(){ 
				$(this).addClass("grayColor");
			},function(){
				$(this).removeClass("grayColor");
			}); // end of $(".line").hover
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
			
		}); // $(document).ready
		function keep() {
			<c:if test='${searchType!=null&&searchType!=""}'>
				$("#searchType").val("${searchType}");
			</c:if>
			<c:if test='${searchString!=null&&searchString!=""}'>
				$("#searchString").val("${searchString}");
			</c:if>
		}
		function goSearch() {
			var frm = document.frm;
			frm.action="<%=request.getContextPath()%>/noticeList.mr";
			frm.method="get";
			frm.submit();
		}
		function goUserInfo(id) {
			var userid = {"userid":id};
			$.ajax({
				url:"noticeUserInfo.mr",
				type:"get",
				data:userid,
				dataType:"html",
				success: function(data) {
					if(data.length>0) {
						$("#userinfo").html(data);
						$("#userinfo").modal(); // 이게 뭐였지????
					}
					else {
						alert("ajax결과"+data);
					}
				},error : function() {
					alert("실패!");
				}
			});
		}
		function goView(n_idx, n_userid, n_t_idx) {
			var frm = document.view;
			frm.idx.value = n_idx;
			frm.userid.value = n_userid; 
			frm.teamidx.value = n_t_idx;
			frm.action="<%=request.getContextPath()%>/noticeView.mr";
			frm.method="get";
			frm.submit();
		}
		function goWrite() {
			<c:if test="${team.teamNum != null&&team.teamNum!=''}" >
				var t_teamNum = "${team.teamNum}";
				alert(t_teamNum);
			</c:if>
			<c:if test="${team.userid != null&&team.userid!=''}">
				var m_userid = "${team.userid}";
			</c:if>
			var frm = document.write;
			frm.teamNum.value= t_teamNum;
			frm.idx.value = $("#nidx").val();
			frm.userid.value=m_userid;
			frm.action="<%=request.getContextPath()%>/noticeWrite.mr";
			frm.method="post";
			frm.submit();
		}
	</script>
	<div class="modal fade" id="userinfo" role="dialog"></div>
</body>
</html>