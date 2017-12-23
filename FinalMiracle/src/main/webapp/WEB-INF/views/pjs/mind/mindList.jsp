<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
.subjectstyle {
	font-weight: bold;
	color: gray;
	cursor: pointer;
}

.selectLine {
	background-color: #eaeaea;
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
	background-color: #eaeaea;
	cursor: pointer;
}

#displayList {
	position: absolute;
	background-color: white;
	width: 189px;
	margin-left: 28px;
	border-top: 0px;
	border: solid gray 3px;
}

#space {
	position: absolute;
}

#custom-search-input {
	padding: 3px;
	border: solid 1px #E4E4E4;
	border-radius: 6px;
	background-color: #fff;
}

#custom-search-input input {
	border: 0;
	box-shadow: none;
}

#custom-search-input button {
	margin: 2px 0 0 0;
	background: none;
	box-shadow: none;
	border: 0;
	color: #666666;
	padding: 0 8px 0 10px;
	border-left: solid 1px #ccc;
}

#custom-search-input button:hover {
	border: 0;
	box-shadow: none;
	border-left: solid 1px #ccc;
}

#custom-search-input .glyphicon-search {
	font-size: 23px;
}
.modal.modal-center {
  text-align: center;
}
@media screen and (min-width: 400px) { 
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
</style>

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
		<input type="hidden" name="idx" /> <input type="hidden" name="userid" />
		<input type="hidden" name="teamNum" />
	</form>
	<form name="write">
		<input type="hidden" name="idx" /> <input type="hidden" name="userid" />
		<input type="hidden" name="teamNum" />
	</form>
	<form name="edit">
		<input type="hidden" name="idx" /> <input type="hidden" name="userid" />
		<input type="hidden" name="teamNum" />
	</form>
	<div align="center">
		<div style="display: block; width: 90%; padding-top: 30px;"
			align="center">
			<div class="panel panel-primary">
				<div class="panel-heading"></div>
				<div style="border: 3px solid #337ab7; padding: 10px;">
					<!-- width:500px; -->
					<span style="color: #034f84; font-size: 12pt; font-weight: bold;"> 마음의 소리 글 </span><br /> <span
						style="color: #4040a1; font-size: 10pt; font-style: italic;">팀 프로젝트에 대해 속마음을 털업!</span>
				</div>
				<br />
				<table class="table table-hover" id="dev-table">
					<thead>
						<tr style="font-size: 12pt; font-weight: bold; background-color: #F0F0F0;">
							<th style="text-align: center; font-family: verdana;">번호</th>
							<!-- 번호 -->
							<th style="text-align: center; font-family: verdana;">아이디</th>
							<!-- 아이디 -->
							<th style="text-align: center; font-family: verdana;">제목</th>
							<!-- 제목 -->
							<th style="text-align: center; font-family: verdana;">글쓴 시간</th>
							<!-- 글쓴 시간 -->
							<th style="text-align: center; font-family: verdana;">첨부파일</th>
							<th style="text-align: center; font-family: verdana;">상태</th>
							<!-- 조회수-->
							<th style="text-align: center; font-family: verdana;"></th>
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
								<tr class="line">
									<!-- d_idx, fk_userid subject regday readcount img, depth, status, t_idx, groupno, tstatus -->
									<td width="5%"
										style="text-align: center; font-family: verdana;"><input
										type="hidden" value="${md.d_idx}" /><input type="checkbox"></td>
									<!-- 번호 -->
									<c:if
										test="${md.tstatus == 2 || sessionScope.loginUser.userid == md.fk_userid}">
										<td width="15%"
											style="text-align: center; font-family: verdana;"><a
											onClick="goUserInfo('${md.fk_userid}');"> <img
												class="imgs"
												src="<%= request.getContextPath()%>/resources/images/${md.img}"
												style="width: 30px; height: 30px;"> <span
												class="userid">${md.fk_userid}</span> <!-- 아이디 -->
										</a></td>
									</c:if>
									<c:if
										test="${md.tstatus == 1 && sessionScope.loginUser.userid != md.fk_userid}">
										<td style="text-align: center; font-family: verdana;">익명</td>
									</c:if>
									<c:if test="${md.depth == 0}">
										<td width="35%"
											onClick="goView('${md.d_idx}','${md.fk_userid}', '${md.t_idx}')"
											style="text-align: left; padding-left: 10px; font-family: verdana;"><span
											style="color: red;">${md.subject}</span></td>
										<!-- 제목 -->
									</c:if>
									<c:if test="${md.depth > 0}">
										<td width="35%"
											onClick="goView('${md.d_idx}','${md.fk_userid}','${md.t_idx}')"
											style="padding-left:${md.depth*10}px; color:black; font-weight:bold; text-align:left;  font-family:verdana;">└
											[답글] ${md.subject}</td>
										<!-- 제목 -->
									</c:if>
									<!-- 제목 -->
									<td width="20%"
										style="text-align: center; font-family: verdana;">${md.regday}</td>
									<!-- 날짜 -->

									<c:if test="${md.file > 0}">
										<td width="8%"
											style="text-align: center; font-family: verdana;"><a
											class="btn btn-default"><span
												class="glyphicon glyphicon-floppy-disk"></span></a></td>
									</c:if>
									<c:if test="${md.file == 0}">
										<td width="8%"
											style="text-align: center; font-family: verdana;">X</td>
									</c:if>

									<td width="7%"
										style="text-align: center; font-family: verdana;"><c:if
											test="${md.depth == 0}">
											<c:if test="${md.readcount == 0}">
										대기중
									</c:if>
											<c:if test="${md.readcount > 0 && md.checkNum == 0}">
										확인
									</c:if>
											<c:if test="${md.checkNum > 0}">
										답변완료
									</c:if>
										</c:if> <c:if test="${md.depth > 0}">
									답변
								</c:if></td>
									<!-- 조회수-->
									<c:if test="${md.fk_userid == sessionScope.loginUser.userid}">
										<td width="15%"
											style="text-align: center; font-family: verdana;"><button
												type="button" class="btn btn-default"
												onClick="goEditView('${md.d_idx}','${md.fk_userid}', '${md.t_idx}');">수정</button></td>
									</c:if>
									<c:if test="${md.fk_userid != sessionScope.loginUser.userid}">
										<td width="15%"
											style="text-align: center; font-family: verdana;"></td>
									</c:if>
								</tr>
								<input type="hidden" id="midx" value="${md.d_idx}" />
							</c:forEach>
						</c:if>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<div id="space">
		<c:if test="${user.status == 1}">
			<button type="button" id="del" class="btn btn-default">삭제</button>
			<button type="button" onClick="goWrite();" class="btn btn-default">글쓰기</button>
		</c:if>
	</div>
	<div align="center" style="padding-bottom: 20px;">${pagebar}</div>
	<form name="frm" align="center" style="border: 0px solid purple;">
		<div align="center" style="border: 0px solid lightgray;">
			<!-- 선택바 -->
			<div class="col-xs-2 nav-container"
				style="border: 0px solid lightgray; margin-left: 300px; margin-top:37px; padding-top: 5px;">
				<div class="form-group" style="float: right;">
					<select class="form-control nav" id="searchType" name="searchType">
						<option value="fk_userid">아이디</option>
						<option value="subject">제목</option>
					</select>
				</div>
			</div>
			<!-- <select id="searchType" name="searchType" style="font-size:12pt;">
				<option value="fk_userid">아이디</option>
				<option value="subject">제목</option>
			</select> -->
			<!-- <input type="text" id="searchString" name="searchString" style="width:187px;"/>
			<button type="button" id="btnClick" onClick="goSearch();">검색</button> -->
			<div style="display: block; z-index: 1000; margin-top: -40px;"
				align="center">
				<div id="displayList"></div>
			</div>
			<!-- 검색바 -->
			<div class="container">
				<div class="row"
					style="border: 0px solid red; height: 30px; padding-right: 420px; display:inline;">
					<div class="col-sm-4" style="border: 0px solid green;">
						<div id="custom-search-input"
							style="border: 1px solid lightgray; margin-left: -15px;">
							<div class="input-group col-sm-12" style="border: 1px solid lightgray;">
								<input type="text" class="form-control input-xs"
									id="searchString" name="searchString" /> <span
									class="input-group-btn">
									<button class="btn btn-info btn-xs" type="button" id="btnClick"
										onClick="goSearch();">
										<i class="glyphicon glyphicon-search"></i>
									</button>
								</span>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</form>

	<script>
		$(document).ready(function(){
			keep();
			var left = $("#dev-table").position().left-45;
			var top = $("#dev-table").position().top-40;
			$("#space").css({"right":left+"px", "bottom":top+"px"});
			
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

			$("#dev-table tr:has(td)").click(function(e){ // tr중에서 td를 가지고 있는 tr
				var bool = $(e.target).parent().hasClass("selectLine"); 
				if(bool) {
					$(e.target).parent().removeClass("selectLine");
				}
				else {
					$(e.target).parent().addClass("selectLine");
				}
			}); // 이부분이 문제!!! */
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
							var left = $("#searchString").position().left;
							var top = $("#searchString").position().top;
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
		/* function goUserInfo(id) {
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
		} */
		function goUserInfo(userid) {
			var form_data = { "userInfo" : userid };
			$.ajax({
				url: "freeUserInfo.mr",
				type: "GET",
				data: form_data,  // url 요청페이지로 보내는 ajax 요청 데이터
				dataType: "JSON", // ajax 요청에 의해 url 요청페이지로 부터 리턴받는 데이터타입. xml, json, html, text 가 있음.
				success: function(data) {				
					var html = "";
					
					var imgPath = data.infoImg;
					html += "<div style='font-family: verdana; font-size: 10pt; border: 2px dotted #E8E8E8; border-radius: 20px; background-color: #F0F0F0; padding: 5px;'><div style='float: right;'><img src='<%= request.getContextPath() %>/resources/files/" + imgPath + "' style='width: 80px; height: 80px; border-radius: 50px;' /></div>" + "<br/>"
						 +  "<span style='font-weight: bold;'>ID : </span>"+ data.infoUserid + "<br/>"
						 +  "<span style='font-weight: bold;'>성명 : </span>"+ data.infoName + "<br/><br/>"
						 +  "<span style='font-weight: bold;'>핸드폰 : </span>" +data.infoHp1 + "-" +data.infoHp2+"-"+data.infoHp3 +"<br/>"
						 +  "<span style='font-weight: bold;'>생년월일 : </span>" +data.infoBirth1 + " / " + data.infoBirth2 + " / " + data.infoBirth3 + "<br/><br/>"
						 +  "<span style='font-weight: bold;'>주소 : </span>" + data.infoAddr1 + " " + data.infoAddr2 + "</span><br/>"
						 +  "<span style='font-weight: bold;'>이메일 : </span>" + data.infoEmail + "<br/><br/>"
						 +  "<span style='font-weight: bold;'>소개 : </span>" + data.infoProfile +"</div>" ;
					
					$(".modal-body").html(html);
					$("#userinfo").modal();
				}, // end of success: function()----------
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
			}); // end of $.ajax()------------------------
		}
		function goView(d_idx, userid, teamNum) {
			var frm = document.view;
			alert(d_idx);
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
	<!-- <div class="modal fade" id="userinfo" role="dialog"></div> -->
	<div class="modal fade modal-center" id="userinfo" role="dialog">
	<div class="modal-dialog modal-sm modal-center">
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
</body>
</html>
